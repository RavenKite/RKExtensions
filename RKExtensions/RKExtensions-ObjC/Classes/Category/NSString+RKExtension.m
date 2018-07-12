//
//  NSString+RKExtension.m
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import "NSString+RKExtension.h"
#import "NSData+RKExtension.h"
#import <CommonCrypto/CommonHMAC.h>

/** 邮箱正则 */
static NSString * const kRegexEamil = @"^[a-z\\d]+(\\.[a-z\\d]+)*@([\\da-z](-[\\da-z])?)+(\\.{1,2}[a-z]+)+$";

/** 手机号正则 */
static NSString * const kRegexPhoneNumber = @"^1\\d{10}";

/** 数字正则（包括形如123、-123、123.02、-123.08的正负整数和小数） */
static NSString * const kRegexNumber = @"^(\\d+|-\\d+)\\d*(.?\\d+|\\d*)$";

/** URLEncode参数 */
static NSString * const kURLEncodeParameter = @"!*'();:@&=+$,/?%#[]";


@implementation NSString (RKExtension)

// MARK: - Encryption & Decryption

- (NSString *)MD5String{
    if(self == nil || [self length] == 0)
        return nil;
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    return [data MD5String];
}

- (NSString *)SHA1String {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data SHA1String];
}


- (NSString *)SHA256String {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data SHA256String];
}

+ (NSString *)hmac_sha1:(NSString *)text key:(NSString *)keyString {
    return [text hmac_sha1WithKey:keyString];
}

- (NSString *)hmac_sha1WithKey:(NSString *)key {
    // URLEncoding
    NSString *urlEncodingString = [self URLEncodeString];
    
    // UTF8 Encoding
    const char *cData = [urlEncodingString cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    // 创建存放加密结果的数组，元素个数为20
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    /**
     *  该方法是HmacSHA1加密的核心方法
     *
     *  @param algorithm#>  加密方式，该变量是一个枚举值，在此处使用kCCHmacAlgSHA1即可 description#>
     *  @param key#>        与后台服务器商定的加密串 description#>
     *  @param keyLength#>  加密串的长度 description#>
     *  @param data#>       需要加密的字符串 description#>
     *  @param dataLength#> 字符串的长度 description#>
     *  @param macOut#>     存放加密结果的数组，该数组有20个元素，每个元素包含两个字符，最终结果字符串需要遍历该数组并拼接得到40字符长度的字符串 description#>
     *
     *  @return 该方法无返回值
     */
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSString *hash = nil;
    // 创建一个可变字符串对象，用于拼接加密结果，长度为40字符
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", cHMAC[i]];
    }
    hash = output;
    
    return hash;
}


// MARK: - Match & Scanner

- (BOOL)isEmail {
    return [self matchedRegex:kRegexEamil];
}

- (BOOL)isPhonNumber {
    return [self matchedRegex:kRegexPhoneNumber];
}

- (BOOL)isNumber {
    return [self matchedRegex:kRegexEamil];
}


// MARK: - URLEncode & URLDecode

- (NSString*)URLEncodeString {
    NSString *encodedString = [self URLEncodeStringWithParameter:kURLEncodeParameter];
    
    return encodedString;
}

- (NSString*)URLEncodeStringWithParameter:(NSString *)parameter {
    NSString *encodedString = self;
    if (@available(iOS 9.0, *)) {
        NSCharacterSet *characterSet = NSCharacterSet.alphanumericCharacterSet;
        encodedString = [self stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    } else {
        CFStringRef cfString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                       (CFStringRef)self,
                                                                       NULL,
                                                                       (CFStringRef)parameter,
                                                                       kCFStringEncodingUTF8);
        encodedString = (NSString *)CFBridgingRelease(cfString);
    }
    
    return encodedString;
}

- (NSString *)URLDecodedString {
    
   CFStringRef cfString = CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault,
                                                                     (CFStringRef)self,
                                                                     CFSTR(""));
//    CFStringRef cfString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
//                                                                                   (CFStringRef)self,
//                                                                                   CFSTR(""),
//                                                                                   kCFStringEncodingUTF8);
    return (NSString *)CFBridgingRelease(cfString);
}



// MARK: - Regex

- (BOOL)matchedRegex:(NSString *)regex {
    NSRegularExpression *regular = [self regularExpressionWithRegex:regex];
    if (!regular) { return false; }
    
    NSUInteger matchCount = [regular numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    
    return matchCount == 0 ? false : true;
}

- (BOOL)containOfRegex:(NSString *)regex {
    NSArray<NSTextCheckingResult *> *results = [self matchesOfRegex:regex];
    
    return results.count;
}

- (NSRange)firstContainOfRegex:(NSString *)regex {
    NSRegularExpression *regular = [self regularExpressionWithRegex:regex];
    if (!regular) { return NSMakeRange(0, 0); }
    
    NSTextCheckingResult *result = [regular firstMatchInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length-1)];
    return result.range;
}

- (NSArray<NSString *> *)componentsMatchedOfRegex:(NSString *)regex {
    NSArray<NSTextCheckingResult *> *results = [self matchesOfRegex:regex];
    
    NSMutableArray<NSString *> *mAry = [NSMutableArray arrayWithCapacity:results.count];
    for (NSTextCheckingResult *result in results) {
        NSString *subStr = [self substringWithRange:result.range];
        if (subStr.length > 0) {
            [mAry addObject:subStr];
        }
    }
    
    [self stringByReplacingOccurrencesOfString:@"" withString:@""];
    
    return mAry;
}

- (NSArray<NSTextCheckingResult *> *)matchesOfRegex:(NSString *)regex {
    NSRegularExpression *regular = [self regularExpressionWithRegex:regex];
    if (!regular) { return nil; }
    
    NSArray<NSTextCheckingResult *> *results = [regular matchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length-1)];
    
    return results;
}

- (NSString *)stringByReplacingOccurencesOfRegex:(NSString *)targetRegex withString:(NSString *)replacement {
    
    return [self stringByReplacingOccurencesOfRegex:targetRegex withString:replacement range:NSMakeRange(0, self.length-1)];
}

- (NSString *)stringByReplacingOccurencesOfRegex:(NSString *)targetRegex withString:(NSString *)replacement range:(NSRange)searchRange {
    NSRegularExpression *regular = [self regularExpressionWithRegex:targetRegex];
    if (!regular) { return self; }
    
    NSString *result = [regular stringByReplacingMatchesInString:self options:NSMatchingReportCompletion range:searchRange withTemplate:replacement];

    return result;
}


// MARK: - Private Method


- (NSRegularExpression *)regularExpressionWithRegex:(NSString *)regex {
    NSError *error = nil;
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    
    return error ? nil : regularExp;
}



@end

























