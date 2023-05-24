//
//  PasswordView.swift
//  shoushimima
//
//  Created by gmy on 2023/5/24.
//  Copyright © 2023 csii. All rights reserved.
//

import Foundation
import UIKit

class PasswordView: UIView {
    // MARK: UI elements
    lazy var imageView = {
        let imageView = UIImageView()
        imageView.frame = bounds
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

    // MARK: property
    public var passwordString: String? {
        get {
            return selectedButtons.map({
                String($0.tag - 1000)
            }).joined()
        }
    }
    var passwordBlock:((String) -> ())?
    var startPoint:CGPoint?
    var endPoint:CGPoint?
    var isDrawFlag:Bool = false

    // MARK: constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        creatButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit")
    }
    
    func creatButtons(){
        for i in 0...8{
            let btn = UIImageView(image: UIImage(named: "blue_circle.png"))
            let x = 10 + 25 + i % 3 * 100
            let y = 20 + i / 3 * 90
            btn.frame = CGRectMake(CGFloat(x), CGFloat(y), 50.0, 50.0)
            btn.tag = 1001 + i
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
//        print(passwordString ?? "空值")
        if let passwordBlock = passwordBlock {
            passwordBlock(passwordString ?? "")
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
