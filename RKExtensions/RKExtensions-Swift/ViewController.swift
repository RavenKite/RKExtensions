//
//  ViewController.swift
//  RKExtensions-Swift
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let str = "123abc天地人#$%"
        
        let encode = str.urlEncode()
        
        
        print_debug(encode)
    }


    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let tabBarVC = self.tabBarController as! RKTabBarController
//        let rect = tabBarVC.barItemFrame(withIndex: 0)
//        print_debug(rect)
    }

}



























