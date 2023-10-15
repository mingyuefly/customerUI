//
//  ViewController.swift
//  graphicsPDF
//  参考：https://www.jianshu.com/p/a82f38358009
//  Created by gmy on 2023/10/9.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let btn1 = UIButton(type: .custom)
        btn1.frame = CGRectMake(0, 100, 100, 30)
        btn1.center.x = view.center.x
        btn1.setTitle("createPDF1", for: .normal)
        btn1.setTitleColor(.red, for: .normal)
        btn1.addTarget(self, action: #selector(createPDF1), for: .touchUpInside)
        view.addSubview(btn1)
        
        let btn2 = UIButton(type: .custom)
        btn2.frame = CGRectMake(0, 150, 100, 30)
        btn2.center.x = view.center.x
        btn2.setTitle("createPDF2", for: .normal)
        btn2.setTitleColor(.red, for: .normal)
        btn2.addTarget(self, action: #selector(createPDF2), for: .touchUpInside)
        view.addSubview(btn2)
        
        let btn3 = UIButton(type: .custom)
        btn3.frame = CGRectMake(0, 200, 100, 30)
        btn3.center.x = view.center.x
        btn3.setTitle("createPDF3", for: .normal)
        btn3.setTitleColor(.red, for: .normal)
        btn3.addTarget(self, action: #selector(createPDF3), for: .touchUpInside)
        view.addSubview(btn3)
    }
    
    @objc func createPDF1() {
        print("createPDF1")
        
        guard let image1 = UIImage(named: "iOSImage") else {
            return
        }
        let image1Rect = CGRect(origin: CGPointMake(0, 0), size: image1.size)
        
        // 反转
        UIGraphicsBeginImageContextWithOptions(image1Rect.size, false, 0)
        guard let cgImage1 = image1.cgImage else {
            return
        }
        let drawImage = UIImage(cgImage: cgImage1, scale: 0, orientation: .downMirrored)
        drawImage.draw(in: CGRect(origin: .zero, size: image1.size))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return
        }
        UIGraphicsEndImageContext()
        
        // 创建二进制流载体
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, image1Rect, nil)
        let context = UIGraphicsGetCurrentContext()
        
        // 绘制第一页
        UIGraphicsBeginPDFPage()
        guard let newCGImage = newImage.cgImage else {
            return
        }
        context?.draw(newCGImage, in: image1Rect, byTiling: true)
        
        //绘制第二页
        UIGraphicsBeginPDFPage()
        context?.draw(cgImage1, in: image1Rect, byTiling: true)
        
        UIGraphicsEndPDFContext()
        
        // 存入沙盒
        guard var dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            return
        }
        dir.appendPathComponent("子线程", conformingTo: .pdf)
        print(dir)
        do {
            try pdfData.write(to: dir)
        } catch {
            print(error)
        }
        
        // 分享
        let activityController = UIActivityViewController.init(activityItems: [pdfData, dir], applicationActivities: nil)
        self.present(activityController, animated: true, completion: { print("弹窗结束")})
    }
    
    @objc func createPDF2() {
        print("createPDF2")
        
        let image = UIImage.init(named: "iOSImage")!
        //使用控件做中间人,这样绘制的时候，图片会是正常的，而不是垂直翻转的，此方法不能放子线程
        let imageView = UIImageView.init(image: image)
        
        //绘制的大小，让文件的每一页大小和图片的大小一致
        let imageRect = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: image.size)
        
        //进入准备工作
        //创建二进制流载体
        let pdfData = NSMutableData.init()
        //设置二进制文件载体
        UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
        //获取上下文，“相当于画板”，必须要在 UIGraphicsBeginPDFContextToData 之后执行,否则绘制出来的文件是空白的
        let context = UIGraphicsGetCurrentContext()
        
        //开始一页的绘制
        UIGraphicsBeginPDFPage()
        //绘制 第一页
        imageView.layer.render(in: context!)
        
        //开始下一页的绘制
        UIGraphicsBeginPDFPage()
        //绘制 第二页
        imageView.layer.render(in: context!)
        
        //结束绘制
        UIGraphicsEndPDFContext()
        
        // 存入沙盒
        guard var dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            return
        }
        dir.appendPathComponent("主线程", conformingTo: .pdf)
        print(dir)
        do {
            try pdfData.write(to: dir)
        } catch {
            print(error)
        }
        
        // 分享
        let activityController = UIActivityViewController.init(activityItems: [pdfData, dir], applicationActivities: nil)
        self.present(activityController, animated: true, completion: { print("弹窗结束")})
    }
    
    @objc func createPDF3() {
        print("createPDF3")
        
        //准备绘制的图片数据
        let image = UIImage.init(named: "iOSImage")!
        //绘制的大小，让文件的每一页大小和图片的大小一致
        var imageRect = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: image.size)
        
        //创建二进制流载体
        let pdfData = NSMutableData.init()
        let pdfConsumer = CGDataConsumer.init(data: pdfData)!
        let pdfContext = CGContext.init(consumer: pdfConsumer, mediaBox: &imageRect, nil)
        
        //        pdfContext?.beginPDFPage(T##pageInfo: CFDictionary?##CFDictionary?)
        pdfContext?.beginPage(mediaBox: &imageRect)
        pdfContext?.draw(image.cgImage!, in: imageRect)
        pdfContext?.endPage()
        
        guard var dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            return
        }
        dir.appendPathComponent("主线程2", conformingTo: .pdf)
        print(dir)
        do {
            try pdfData.write(to: dir)
        } catch {
            print(error)
        }
        
        // 分享
        let activityController = UIActivityViewController.init(activityItems: [pdfData, dir], applicationActivities: nil)
        self.present(activityController, animated: true, completion: { print("弹窗结束")})
    }
}

