//
//  RKTabBarController.swift
//  RKExtensions-Swift
//
//  Created by 李沛倬 on 2018/7/12.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

import UIKit

class RKTabBarController: UITabBarController {
    
    /// 是否支持ForceTouch(3D Touch)
    public var forceTouchAvailable : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 9.0, *) {
            self.forceTouchAvailable = self.traitCollection.forceTouchCapability == .available
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 9.0, *) {
            self.forceTouchAvailable = previousTraitCollection?.forceTouchCapability == .available
        }
    }
    
    
    // MARK: - Public Method
    
    
    ///  获取指定barItem的frame
    ///
    /// - Parameter index: barItem下标
    /// - Returns: barItem's frame
    func barItemFrame(withIndex index: Int) -> CGRect {
        if index >= (self.tabBar.items?.count ?? 0 ) { return CGRect.zero }
        
        var flag = -1
        for view in self.tabBar.subviews {
            if let cls = NSClassFromString("UITabBarButton") {
                if view.isKind(of: cls) {
                    flag += 1
                    if flag == index {
                        let rect = self.tabBar.convert(view.frame, to: self.view)
                        return rect
                    }
                }
            }
        }
        
        return CGRect.zero
    }

    
}



// MARK: - UITabBarControllerDelegate

extension RKTabBarController : UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if #available(iOS 10.0, *) {    // 线性马达触摸震动反馈(仅支持iPhone 7及以上拥有线性马达的设备)
            UISelectionFeedbackGenerator.init().selectionChanged()
        }
        
    }
    
}






















