//
//  String+RKExtension.swift
//  RKExtensions-Swift
//
//  Created by 李沛倬 on 2018/7/8.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

import Foundation


// MARK: - Regex

extension String {
    // MARK: - Public Methods
    /// 判断一个字符串中是否包含指定的字符串
    func contains(_ text: String) -> Bool {
        return self.range(of: text)?.lowerBound == nil ? false : true
    }
    
    /// 判断字符串中是否匹配到传入的正则表达式的字符串
    func containsOfRegex(_ regex: String) -> Bool {
        if let rangeArr = self.rangesOfRegex(regex) {
            return rangeArr.count > 0
        }
        return false
    }
    
    /// 返回传入的正则表达式匹配到的第一个字符串的range
    func firstMatchedOfRegex(_ regex: String) -> NSRange? {
        let regular = self.getRegularExpression(regex)
        let result = regular?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.count-1))
        return result?.range
    }
    
    /// 找出字符串中匹配传入的正则表达式的字符串，以数组的形式返回匹配到的字符串集合
    func componentsMatchedOfRegex(_ regex: String) -> [String]? {
        let rangeArr = self.rangesOfRegex(regex)
        if rangeArr == nil { return nil }
        
        var returnArr = [String]()
        for range in rangeArr! {
            let text = self as NSString
            returnArr += [text.substring(with: range) as String]
        }
        return returnArr
    }
    
    /**
     根据传入的正则表达式查询字符串中匹配到的字符串Range信息，以数组形式返回
     - parameter regex: 正则表达式字符串
     - returns: NSRange数组
     */
    func rangesOfRegex(_ regex: String) -> [NSRange]? {
        let regular = self.getRegularExpression(regex)
        if regular == nil { return nil }
        
        let matches = regular!.matches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count-1))
        var rangeArr = [NSRange]()
        for result in matches {
            rangeArr += [result.range]
        }
        
        return rangeArr
    }
    
    /// 用『replaceString』替换掉满足传入的正则表达式的所有字符串，并返回替换后的字符串
    func replacingOccurencesOfRegex(_ regex: String, replaceString: String) -> String {
        return self.replacingOccurencesOfRegex(regex, replaceString: replaceString, searchRange: NSMakeRange(0, self.count))
    }
    
    /// 用『replaceString』替换掉满足传入的正则表达式的所有字符串，并返回替换后的字符串
    func replacingOccurencesOfRegex(_ regex: String, replaceString: String, searchRange: NSRange) -> String {
        let regular = getRegularExpression(regex)
        let resultStr = regular?.stringByReplacingMatches(in: self, options: .reportCompletion, range: searchRange, withTemplate: replaceString)
        
        return resultStr ?? self;
    }
    
    /// 将指定range范围内的内容替换为指定的字符串
    func replacingStringInRange(_ range: NSRange, withString: String) -> String {
        return NSString(string: self).replacingCharacters(in: range, with: withString)
    }
    
    /**
     将JSON字符串转换成字典
     */
    func jsonStrToDictionary() -> [String: AnyObject]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                let dic = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                return dic as? [String: AnyObject]
            } catch {
                print_debug(error)
            }
        }
        return nil
    }
    
    
    /// 判断当前字符串是否为邮箱
    ///
    /// - Returns: 为邮箱返回true，否则返回false
    func isEmail() -> Bool {
        return getMatchCountWithRegex(regex: RegexString.Email) > 0 ? true : false
    }
    
    /// 判断当前字符串是否为纯数字（包括正负整数和小数）。
    /// 形如123、-123、123.02、-123.08都判定为纯数字
    /// - Returns: 为纯数字返回true，否则返回false
    func isNumber() -> Bool {
        return getMatchCountWithRegex(regex: RegexString.number) > 0 ? true : false
    }
    
    /// 判断当前字符串是否为手机号
    ///
    /// - Returns: 为手机号返回true，否则返回false
    func isPhoneNumber() -> Bool {
        return getMatchCountWithRegex(regex: RegexString.phoneNumber) > 0 ? true : false
    }
    
    
    // MARK: - Private Methods
    fileprivate func getMatchCountWithRegex(regex: RegexString) -> Int {
        let regular = getRegularExpression(regex.rawValue)
        return regular?.numberOfMatches(in: self, options: .reportProgress, range: NSMakeRange(0, self.count)) ?? 0
    }
    
    fileprivate func getRegularExpression(_ regex: String) -> NSRegularExpression? {
        var regexR: NSRegularExpression?
        do {
            regexR = try NSRegularExpression.init(pattern: regex, options: NSRegularExpression.Options.caseInsensitive)
        } catch {
            regexR = nil
            print_debug("ERROR!!")
        }
        
        return regexR
    }
    
}



// MARK: - URLEncode & URLDecode

extension String {
    
    func urlEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) ?? self
    }
    
    func urlDecode() -> String {
        return self.removingPercentEncoding ?? self
    }
    
}


// MARK: - =~运算符重载
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


struct RegexHelper {
    let regex: NSRegularExpression
    
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern,
                                        options: .caseInsensitive)
    }
    
    func match(_ input: String) -> Bool {
        let matches = regex.matches(in: input,
                                    options: [],
                                    range: NSMakeRange(0, input.count))
        return matches.count > 0
    }
}


/// 正则表达式
///
/// - Email: 邮箱正则
/// - number: 数字正则（包括形如123、-123、123.02、-123.08的正负整数和小数）
/// - phoneNumber: 手机号正则
enum RegexString: String {
    case Email          = "^[a-z\\d]+(\\.[a-z\\d]+)*@([\\da-z](-[\\da-z])?)+(\\.{1,2}[a-z]+)+$"
    case number         = "^(\\d+|-\\d+)\\d*(.?\\d+|\\d*)$"
    case phoneNumber    = "^1\\d{10}"
}

/// =~运算符可使用正则表达式，返回一个bool值用于判断=~左边的字符串是否满足右边的正则表达式
infix operator =~ : regex

precedencegroup regex {
    associativity: none
    lowerThan: AdditionPrecedence
}


func =~(lhs: String, rhs: String) -> Bool {
    return (try? RegexHelper(rhs).match(lhs)) ?? false
}










