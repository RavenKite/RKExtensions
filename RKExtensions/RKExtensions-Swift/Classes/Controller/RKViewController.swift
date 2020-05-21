//
//  RKViewController.swift
//  RKExtensions-Swift
//
//  Created by 李沛倬 on 2018/7/12.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol RKViewControllerDelegate : NSObjectProtocol {
    
    @objc optional func coverViewDidClicked(coverView : UIVisualEffectView)
    
}


class RKViewController: UIViewController {
    
    public weak var delegate: RKViewControllerDelegate?
    

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    
    
    // MARK: - Public Func
    
    /// 设置状态栏颜色: 如需改变页面的状态栏颜色，可通过该方法在viewWillAppear中设置，别忘记在viewWillDisappear中还原
    ///
    /// - Parameter color: 状态栏颜色
    public func statusBarBackgroundColor(_ color: UIColor) -> Void {
        let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as? UIView)?.value(forKey: "statusBar") as? UIView
        statusBar?.backgroundColor = color
    }
    
    ///  返回导航栏分割线: 可用于控制隐藏和显示导航栏分割线
    public func navigationBarSeparatorView() -> UIView? {
        
        if let navi = self.navigationController {
            for view in navi.navigationBar.subviews {
                
                var target: UIView = UIView.init()
                if let cls = NSClassFromString("_UIBarBackground") {
                    if view.isKind(of: cls) {
                        target = view
                    }
                } else if let cls = NSClassFromString("_UINavigationBarBackground") {
                    if view.isKind(of: cls) {
                        target = view
                    }
                }
                
                for subview in target.subviews {
                    if subview.bounds.size.height <= 1 {
                        return subview
                    }
                }
            }
        }

        return nil
    }
    
    
    // MARK: - Loading
    
    
    // MARK: - Cover

    public lazy var coverView : UIVisualEffectView = {
        let effect = UIBlurEffect.init(style: .light)
        let coverView = UIVisualEffectView.init(effect: effect)
        coverView.alpha = 0
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(coverViewGestureAction(sender:)))
        coverView.addGestureRecognizer(tap)

        view.addSubview(coverView)
        
        coverView.snp.makeConstraints({ (make) in
            make.edges.equalTo(coverView.superview!)
        })
        
        return coverView
    }()
    
    
    
    @objc fileprivate func coverViewGestureAction(sender: UITapGestureRecognizer) -> Void {
        
        delegate?.coverViewDidClicked?(coverView: coverView)
        
    }
    
    
    
    
    
    // MARK: - Keyboard Resign
    



}



























