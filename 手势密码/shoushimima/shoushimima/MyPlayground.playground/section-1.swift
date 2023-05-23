// Playground - noun: a place where people can play

import UIKit

print("hello")

class ViewController: UIViewController {
    var imageView:UIImageView!
    var buttons:NSMutableArray!
    var selectedButtons:NSMutableArray!
    var startPoint:CGPoint!
    var endPoint:CGPoint!
    var isDrawFlag:Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatButtons();
        print("hello")
    }
    
    func creatButtons(){
        for i in 0...9{
            var btn = UIImageView(image: UIImage(named: "blue_circle.png"))
            var x = 30 + i % 3 * 100
            var y = 20 + i / 3 * 90
            btn.frame = CGRectMake(CGFloat(x), CGFloat(y), 50.0, 50.0)
            btn.tag = 1000 + i
            imageView.addSubview(btn)
            buttons.addObject(btn)
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

