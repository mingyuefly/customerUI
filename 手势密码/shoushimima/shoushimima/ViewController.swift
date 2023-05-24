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
    lazy var imageView = {
        let imageView = UIImageView()
        imageView.frame = CGRectMake(0, 100, 320, 400)
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    lazy var buttons = {
        let buttons = [UIImageView]()
        return buttons
    }()
    
    lazy var selectedButtons = {
        let selectedButtons = [UIImageView]()
        return selectedButtons
    }()
    
    var startPoint:CGPoint?
    var endPoint:CGPoint?
    var isDrawFlag:Bool = false
    
    // MARK: view life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
        creatButtons();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func creatButtons(){
        for i in 0...8{
            let btn = UIImageView(image: UIImage(named: "blue_circle.png"))
            let x = 30 + 27 + i % 3 * 100
            let y = 20 + i / 3 * 90
            btn.frame = CGRectMake(CGFloat(x), CGFloat(y), 50.0, 50.0)
            btn.tag = 1000 + i
            imageView.addSubview(btn)
            buttons.append(btn)
        }
    }
    
    func clearData(){
        imageView.image = nil
        isDrawFlag = false
        buttons.forEach { btn in
            btn.image = UIImage(named: "blue_circle.png")
        }
        selectedButtons.removeAll()
    }
    
    // MARK: touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 清除之前数据
        clearData()
        let point = touches.first?.location(in: imageView)
        buttons.forEach { btn in
            if let point = point {
                if CGRectContainsPoint(btn.frame, point) {
                    // 赋画线初值
                    startPoint = btn.center
                    isDrawFlag = true;
                    selectedButtons.append(btn)
                    btn.image = UIImage(named: "red_circle.png")
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: imageView)
        if isDrawFlag {
            endPoint = point
            buttons.forEach { btn in
                if let point = point, CGRectContainsPoint(btn.frame, point) {
                    if !selectedButtons.contains(btn) {
                        selectedButtons.append(btn)
                        btn.image = UIImage(named: "red_circle.png")
                    }
                }
            }
            imageView.image = drawUnlocLine()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if selectedButtons.count > 0, let lastBtn = selectedButtons.last {
            endPoint = lastBtn.center
            imageView.image = drawUnlocLine()
        }
    }
    
    // MARK: draw methods
    func drawUnlocLine() -> UIImage? {
        UIGraphicsBeginImageContext(imageView.frame.size);
        guard let context:CGContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setLineWidth(5.0);
        context.setFillColor(UIColor.green.cgColor)
        context.setStrokeColor(UIColor.red.cgColor)
        
        if let startPoint = startPoint {
            context.move(to: startPoint)
        }
        
        selectedButtons.forEach { btn in
            context.addLine(to: btn.center)
        }
        
        if let btn = selectedButtons.last, let endPoint = endPoint, btn.center != endPoint  {
            context.addLine(to: endPoint)
        }
        
        context.strokePath()
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage(named: "")!
        UIGraphicsEndImageContext()
        return image
    }
}

