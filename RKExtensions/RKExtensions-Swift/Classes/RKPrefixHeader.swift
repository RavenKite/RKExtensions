//
//  RKPrefixHeader.swift
//  RKExtensions-Swift
//
//  Created by 李沛倬 on 2018/7/8.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

import UIKit


/// info.plist
let PZInfoDict = Bundle.main.infoDictionary!

/// app名称
let PZAppName = PZInfoDict[InfoDictKeys.bundleName] as! String

/// app版本 eg. 1.0.0
let PZAppVersion = PZInfoDict[InfoDictKeys.appVersion] as! String

/// app build版本 eg. 1
let PZAppBuild = PZInfoDict[InfoDictKeys.appBuild] as! String

/// iOS 系统版本 eg. 10.2.2
let PZSystemVersion = UIDevice.current.systemVersion

/// 设备唯一标识 UUID
let PZDeviceUUID = UIDevice.current.identifierForVendor!.uuidString



///  DEBUG打印
///
///  - parameter message: 要打印的内容，可以为空
///  - parameter file:    所属文件
///  - parameter line:    行号
///  - parameter method:  所在方法名
func print_debug(_ message: Any! = "", file: String = #file, line: Int = #line, method: String = #function) {
    #if DEBUG
    print("【\((file as NSString).lastPathComponent) -> \(method) -> \(line)】: \(message!)")
    #endif
}







// MARK: - Private
fileprivate struct InfoDictKeys {
    
    static var bundleName   = "CFBundleName"
    static var appVersion   = "CFBundleShortVersionString"
    static var appBuild     = "CFBundleVersion"
    
}

