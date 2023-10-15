//
//  ViewController.swift
//  activity
//
//  Created by gmy on 2023/9/26.
//
/**
 note:
 无法将main bundle中的资源通过FileManager的copy方法复制到沙箱中，同样Mac桌面的文件也不能通过FileManager的copy方法复制到沙箱中，可以通过NSData写入沙箱中。
 */


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
        button.center = CGPoint(x: view.bounds.width / 2, y: 115)
        button.setTitle("activity", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(activityAction), for: .touchUpInside)
        view.addSubview(button)
        
        let button1 = UIButton(type: .custom)
        button1.frame = CGRect(x: 0, y: 150, width: 100, height: 30)
        button1.center = CGPoint(x: view.bounds.width / 2, y: 165)
        button1.setTitle("savePDF", for: .normal)
        button1.setTitleColor(.red, for: .normal)
        button1.addTarget(self, action: #selector(savePDFAction), for: .touchUpInside)
        view.addSubview(button1)
        
        let button2 = UIButton(type: .custom)
        button2.frame = CGRect(x: 0, y: 200, width: 100, height: 30)
        button2.center = CGPoint(x: view.bounds.width / 2, y: 215)
        button2.setTitle("sharePng", for: .normal)
        button2.setTitleColor(.red, for: .normal)
        button2.addTarget(self, action: #selector(savePngAction), for: .touchUpInside)
        view.addSubview(button2)
    }

    @objc func activityAction() {
        print("activityAction")
        let content = "活动的内容"
        guard let url = URL(string: "https://www.baidu.com") else {
            return
        }
        guard let image = UIImage(named: "iOSImage") else {
            return
        }
        // 系统UI弹窗
        let activityVC = UIActivityViewController(activityItems: [content, url, image], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, activityError: Error?) in
            print("activityType: \(activityType) completed:\(completed) returnedItems:\(returnedItems) activityError:\(activityError)")
        }
        self.navigationController?.present(activityVC, animated: true)
    }

    @objc func savePDFAction() {
        print("savePDFAction \(NSHomeDirectory())")
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        var documentPath: NSString = ""
        if let documentPath1 = paths.last {
            documentPath = documentPath1 as NSString
        }
        // swift的文件拼接使用URL，最低支持iOS14，这块儿部分使用OC
        let policyPath: NSString = documentPath.appendingPathComponent("service") as NSString
//        let policypathURL = NSURL(string: policyPath as String)
        let fileManager = FileManager.default
        var filePath = ""
        if !fileManager.fileExists(atPath: policyPath as String) {
            do {
                try fileManager.createDirectory(atPath: policyPath as String, withIntermediateDirectories: true)
                filePath = policyPath.appendingPathComponent("title.pdf")
            } catch {
                filePath = documentPath.appendingPathComponent("title.pdf")
                print(error)
            }
        } else {
            filePath = policyPath.appendingPathComponent("title.pdf")
        }
        
//        let fileHandler = FileHandle(forReadingAtPath: "/Users/gmy/Documents/iOS/UI/customerUI/activity/swift/CloseButton.pdf")
        guard let closeButtonPath = Bundle.main.path(forResource: "CloseButton.pdf", ofType: nil) else {
            return
        }
        let fileHandler = FileHandle(forReadingAtPath: closeButtonPath)
        
        
//        guard let fileLength = fileHandler?.seekToEndOfFile() else { return }
//        do {
//            // 支持iOS13
//            try fileHandler?.seek(toOffset: 0)
//            do {
//                let data = try fileHandler?.readData(ofLength: Int(fileLength))
//                print(data)
//                fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
//                print("write success")
//            } catch {
//                print(error)
//            }
//        } catch {
//            print(error)
//        }
        
        
//        do {
//            // 支持iOS13.4
//            let data = try fileHandler?.readToEnd()
//            print(data)
//            fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
//            print("write success")
//        } catch {
//            print(error)
//        }
        
        let data = fileHandler?.readDataToEndOfFile()
        print(data)
        fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
        print("write success")
        
        
        
//        if let sourcePathURL = URL(string: "/Users/gmy/Documents/iOS/UI/customerUI/activity/CloseButton.pdf"), let policypathURL = URL(string: policyPath as String) {
//            do {
//                try fileManager.copyItem(at: sourcePathURL, to: policypathURL)
//                print("copy success")
//            } catch {
//                print(error)
//            }
//        }
        
        print(filePath)
//        let filePathUrl = URL(fileURLWithPath: filePath)
        let filePathUrl = URL(string: filePath)
        // public init(fileURLWithPath path: String)和public init?(string: String)区别：
//        fileURLWithPath生成的URL会有file:///前缀，
//        合法，init?(string:不会有file:///前缀，不合法
        
//        let doc: UIDocumentInteractionController = UIDocumentInteractionController(url: filePathUrl)
//        doc.delegate = self
//        doc.presentPreview(animated: true)
        
        let items:[Any] = [filePathUrl]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, activityError: Error?) in
            print("activityType: \(activityType) completed:\(completed) returnedItems:\(returnedItems) activityError:\(activityError)")
        }
        self.navigationController?.present(activityVC, animated: true)
    }
    
    @objc func savePngAction() {
        print("savePngAction \(NSHomeDirectory())")
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        var documentPath: NSString = ""
        if let documentPath1 = paths.last {
            documentPath = documentPath1 as NSString
        }
        // swift的文件拼接使用URL，最低支持iOS14，这块儿部分使用OC
        let imagePath: NSString = documentPath.appendingPathComponent("pictures") as NSString
//        let imagePathURL = NSURL(string: imagePath as String)
        let fileManager = FileManager.default
        var filePath = ""
        if !fileManager.fileExists(atPath: imagePath as String) {
            do {
                try fileManager.createDirectory(atPath: imagePath as String, withIntermediateDirectories: true)
                filePath = imagePath.appendingPathComponent("title.png")
            } catch {
                filePath = documentPath.appendingPathComponent("title.png")
                print(error)
            }
        } else {
            filePath = imagePath.appendingPathComponent("title.png")
        }
//        let fileHandler = FileHandle(forReadingAtPath: "/Users/gmy/Documents/iOS/UI/customerUI/activity/swift/iOS.png")
        guard let iOSpath = Bundle.main.path(forResource: "iOS.png", ofType: nil) else {
            return
        }
        let fileHandler = FileHandle(forReadingAtPath: iOSpath)
        let data = fileHandler?.readDataToEndOfFile()
        print(data)
        fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
        print("write success")
        print(filePath)
        let filePathUrl = URL(fileURLWithPath: filePath)
    
//        let doc: UIDocumentInteractionController = UIDocumentInteractionController(url: filePathUrl)
//        doc.delegate = self
//        doc.presentPreview(animated: true)
        
        let items:[Any] = [filePathUrl]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, activityError: Error?) in
            print("activityType: \(activityType) completed:\(completed) returnedItems:\(returnedItems) activityError:\(activityError)")
        }
        self.navigationController?.present(activityVC, animated: true)
    }
    
    /// MARK:  UIDocumentInteractionControllerDelegate
    ///
}

extension ViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return self.view
    }
    func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return CGRect(x: 0, y: 30, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    }
}

