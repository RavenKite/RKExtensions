//
//  NSString+RKExtension.h
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RKExtension)

// MARK: - Encryption & Decryption

- (NSString *)MD5String;

- (NSString *)SHA1String;

- (NSString *)SHA256String;


/**
 *  类方法：将传入的字符串按指定的key进行HmacSHA1加密，并返回加密结果字符串
 *
 *  @param text 需要加密的字符串
 *  @param key  客户端与后台服务器商定的加密串
 *
 *  @return HmacSHA1加密后的字符串
 */
+ (NSString *)hmac_sha1:(NSString *)text key:(NSString *)key;

/**
 *  实例方法：将当前字符串按指定的key进行HmacSHA1加密，并返回加密结果字符串
 *
 *  @param key  客户端与后台服务器商定的加密串
 *
 *  @return HmacSHA1加密后的字符串
 */
- (NSString *)hmac_sha1WithKey:(NSString *)key;



// MARK: - Match & Scanner

- (BOOL)isEmail;

- (BOOL)isPhonNumber;

- (BOOL)isNumber;



// MARK: - URLEncode & URLDecode

- (NSString *)URLEncodeString;

- (NSString *)URLEncodeStringWithParameter:(NSString *)parameter;

- (NSString *)URLDecodedString;


// MARK: - Regex

/**
 字符串是否满足传入的正则表达式
 
 @param regex 正则表达式字符串
 @return true为当前字符串满足该正则表达式，反之则为false
 */
- (BOOL)matchedRegex:(NSString *)regex;


/**
 判断字符串中是否包含传入的正则表达式的字符串

 @param regex 正则表达式字符串
 @return true为字符串中包含满足该正则表达式的字符串
 */
- (BOOL)containOfRegex:(NSString *)regex;



/**
 返回传入的正则表达式匹配到的第一个字符串的range

 @param regex 正则表达式字符串
 @return 满足传入正则表达式的第一个字符串
 */
- (NSRange)firstContainOfRegex:(NSString *)regex;


/**
 找出字符串中匹配传入的正则表达式的字符串，以数组的形式返回匹配到的字符串集合

 @param regex 正则表达式字符串
 @return 匹配正则表达式的字符串数组
 */
- (NSArray<NSString *> *)componentsMatchedOfRegex:(NSString *)regex;


/**
 找出字符串中匹配传入的正则表达式的结果，以数组的形式返回匹配到的结果

 @param regex 正则表达式字符串
 @return 匹配正则表达式的结果数组
 */
- (NSArray<NSTextCheckingResult *> *)matchesOfRegex:(NSString *)regex;


/**
 替换满足传入的正则表达式的所有字符串，并返回替换后的字符串

 @param targetRegex 正则表达式字符串
 @param replacement 替换字符串
 @param searchRange 查询范围
 @return 替换后的字符串
 */
- (NSString *)stringByReplacingOccurencesOfRegex:(NSString *)targetRegex withString:(NSString *)replacement range:(NSRange)searchRange;
- (NSString *)stringByReplacingOccurencesOfRegex:(NSString *)targetRegex withString:(NSString *)replacement;



@end


















