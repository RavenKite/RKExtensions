//
//  RKNavigationController.swift
//  RKExtensions-Swift
//
//  Created by 李沛倬 on 2018/7/12.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

import UIKit

class RKNavigationController: UINavigationController {
    
    public var backItemImage : UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.replacePopGesture()
    }
    
    fileprivate func replacePopGesture() {
        
        let sel = NSSelectorFromString("handleNavigationTransition:")
        
        if self.interactivePopGestureRecognizer?.delegate?.responds(to: sel) == true {
            let pan = UIPanGestureRecognizer.init(target: self.interactivePopGestureRecognizer?.delegate, action: sel)
            pan.delegate = self
            
            self.view.addGestureRecognizer(pan)
        }
    }
    
    
    fileprivate func configNavigationBarBackItem() {
        if self.viewControllers.count < 2 || self.backItemImage == nil { return }
        
        let backItem = UIBarButtonItem.init(image: self.backItemImage!, style: .plain, target: self, action: #selector(backBarItemAction(sender:)))
        
        self.topViewController?.navigationItem.leftBarButtonItem = backItem
    }

    
    @objc fileprivate func backBarItemAction(sender : UIBarButtonItem) {
        self.popViewController(animated: true)
    }

}


// MARK: - UIGestureRecognizerDelegate

extension RKNavigationController : UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        
        return self.viewControllers.count != 1
    }
}


// MARK: - UINavigationControllerDelegate

extension RKNavigationController : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        self.configNavigationBarBackItem()
        
        print_debug(viewController)
    }

    
}































