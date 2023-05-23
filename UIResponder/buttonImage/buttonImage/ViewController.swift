//
//  ViewController.swift
//  buttonImage
//
//  Created by mingyue on 15-7-19.
//  Copyright (c) 2015年 csii. All rights reserved.
//
/**
 测试响应链
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(frame: CGRectMake(100, 100, 100, 30))
        button.backgroundColor = UIColor.red
        button.setTitle("button", for: .normal)
        button.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        self.view.addSubview(button)
        
        let iv = UIImageView(frame: CGRect(origin: CGPointMake(100, 100), size: CGSizeMake(100, 30)))
        iv.backgroundColor = UIColor.green
//        self.view.addSubview(iv)
        
        let iv1 = UIImageView(frame: CGRectMake(0,0, 100, 30))
        iv1.backgroundColor = UIColor.purple
        iv1.alpha = 1.0
        button.addSubview(iv1)
    }

    @objc func btnAction(){
        print("btnAction")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

