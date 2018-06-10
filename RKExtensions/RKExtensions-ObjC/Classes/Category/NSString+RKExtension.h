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

/**
 字符串是否满足传入的正则表达式
 
 @param regex 正则表达式字符串
 @return true为当前字符串满足该正则表达式，反之则为false
 */
- (BOOL)isMatchedWithRegex:(NSString *)regex;


// MARK: - URLEncode & URLDecode

- (NSString *)URLEncodeString;

- (NSString *)URLEncodeStringWithParameter:(NSString *)parameter;

- (NSString *)URLDecodedString;

@end











