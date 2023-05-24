//
//  ViewController.swift
//  shoushimima
//
//  Created by mingyue on 15-7-24.
//  Copyright (c) 2015年 csii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: UI elements
    lazy var passwordView: PasswordView = {
        let view = PasswordView(frame: CGRectMake(0, 100, 320, 400))
        view.center.x = self.view.center.x
        view.passwordBlock = { (password) in
            print(password)
        }
        return view
    }()
    
    // MARK: propery
    var passwordStr: String? {
        get {
            return passwordView.passwordString
        }
    }
    
    // MARK: view life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(passwordView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: password methos
    func passwordFunc() {
        guard let passwordStr = passwordStr else {
            return
        }
        print(passwordStr)
    }
}

