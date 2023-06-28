//
//  ViewController.swift
//  moveImage
//
//  Created by gmy on 2023/6/28.
//

import UIKit

class ViewController: UIViewController {
    /// MARK: property, UI elements
    var count = 0
    var imageWidth: CGFloat = 0.0
    var imageHeight: CGFloat = 0.0
    var from: Int = -1
    var to: Int = -1
    var dragView: UIImageView?
    lazy var containerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 64, width: Int(view.bounds.width), height: Int(view.bounds.height) - 64))
//        view.backgroundColor = .blue
        return view
    }()
    lazy var imageViews: [UIImageView] = {
        var ivs = [UIImageView]()
        images.forEach { image in
            let imageView = UIImageView()
            imageView.image = image
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_ :)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(longPress)
            ivs.append(imageView)
        }
        return ivs
    }()
    lazy var images: [UIImage] = {
        var images = [UIImage]()
        fileNames.forEach { imageName in
            if let image = UIImage(named: imageName) {
                images.append(image)
            }
        }
        return images
    }()
    lazy var fileNames: [String] = {
        var arr = [String]()
        let manager = FileManager.default
        if let appPath = Bundle.main.path(forResource: "beautyImages", ofType: "") {
            do {
                arr = try manager.contentsOfDirectory(atPath: appPath)
            } catch {
                print(error)
            }
        }
        self.count = arr.count
        return arr
    }()
    /// MARK: root view life time
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(containerView)
        imageWidth = view.bounds.size.width / 4
        imageHeight = imageWidth
        
        for i in 0..<fileNames.count {
            let frame = CGRectMake(CGFloat((i % 4)) * imageWidth, CGFloat((i / 4)) * imageHeight, imageWidth, imageHeight)
            let imageView = imageViews[i]
            imageView.frame = frame
            imageView.tag = i
            containerView.addSubview(imageView)
        }
    }
    
    /// MARK: update UI
    func updateUI() {
        for i in 0..<fileNames.count {
            if i == to {
                continue
            }
            let imageView = imageViews[i]
            imageView.tag = i
            containerView.addSubview(imageView)
            UIView.animate(withDuration: 2) {
                let frame = CGRectMake(CGFloat((i % 4)) * self.imageWidth, CGFloat((i / 4)) * self.imageHeight, self.imageWidth, self.imageHeight)
                imageView.frame = frame
            }
        }
    }

    /// MARK: actions
    @objc func longPressAction(_ sender : UILongPressGestureRecognizer) {
        print("long press")
        dragView = sender.view as? UIImageView
        guard let drageView1 = dragView else {
            return
        }
        let point = sender.location(in: containerView)
        drageView1.center = point
        containerView.bringSubviewToFront(drageView1)
        if let index = imageViews.firstIndex(of: drageView1) {
            imageViews.remove(at: index)
        }
        from = drageView1.tag
        
        for iv in imageViews {
            if CGRectContainsPoint(iv.frame, point) {
                to = iv.tag
                imageViews.insert(drageView1, at: to)
                drageView1.tag = to
                updateUI()
                break
            }
        }
        
        if sender.state == .ended {
            imageViews.insert(drageView1, at: to)
            to = -1
            updateUI()
        }
    }
}

