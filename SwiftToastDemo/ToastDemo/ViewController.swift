//
//  ViewController.swift
//  ToastDemo
//
//  Created by Rannie on 14/7/6.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

import UIKit

let ButtonWidth  : CGFloat = 120.0
let ButtonHeight : CGFloat = 40.0
let MarginY      : CGFloat = 10.0
let MarginX      = (UIScreen.mainScreen().bounds.size.width - ButtonWidth) / 2

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Swift Toast"
        self.edgesForExtendedLayout = .None
        
        self.setupButtons()
    }
    
    func setupButtons() {
        var singleToastBtn   = self.quickAddButtonWithTitle("Single Toast", target: self, action: Selector("handleSingleToastClicked:"))
        singleToastBtn.frame = CGRectMake(MarginX, 2*MarginY, ButtonWidth, ButtonHeight)
        self.view.addSubview(singleToastBtn)
        
        var titleToastBtn    = self.quickAddButtonWithTitle("Title Toast", target: self, action: Selector("handleTitleToastClicked:"))
        titleToastBtn.frame  = CGRectMake(MarginX, 3*MarginY + ButtonHeight, ButtonWidth, ButtonHeight)
        self.view.addSubview(titleToastBtn)
        
        var imageToastBtn    = self.quickAddButtonWithTitle("Image Toast", target: self, action: Selector("handleImageToastClicked:"))
        imageToastBtn.frame  = CGRectMake(MarginX, 4*MarginY + 2*ButtonHeight, ButtonWidth, ButtonHeight)
        self.view.addSubview(imageToastBtn)
        
        var showActivityBtn   = self.quickAddButtonWithTitle("Show Activity", target: self, action: Selector("showActivity"))
        showActivityBtn.frame = CGRectMake(MarginX, 5*MarginY + 3*ButtonHeight, ButtonWidth, ButtonHeight)
        self.view.addSubview(showActivityBtn)
        
        var hideActivityBtn   = self.quickAddButtonWithTitle("Hide Activity", target: self, action: Selector("hideActivity"))
        hideActivityBtn.frame = CGRectMake(MarginX, 6*MarginY + 6*ButtonHeight, ButtonWidth, ButtonHeight)
        self.view.addSubview(hideActivityBtn)
    }
    
    // handle events
    func handleSingleToastClicked(sender: UIButton) {
        self.view.makeToast(message: sender.titleForState(.Normal)!)
    }
    
    func handleTitleToastClicked(sender: UIButton) {
        self.view.makeToast(message: sender.titleForState(.Normal)!, duration: 2, position: HRToastPositionTop, title: "<Title>")
    }
    
    func handleImageToastClicked(sender: UIButton) {
        var image = UIImage(named: "swift-logo.png")
        self.view.makeToast(message: sender.titleForState(.Normal)!, duration: 2, position: "center", title: "Image!", image: image!)
    }
    
    func showActivity() {
        self.view.makeToastActivity()
    }
    
    func hideActivity() {
        self.view.hideToastActivity()
    }
    
    // ui helper
    func quickAddButtonWithTitle(title: String, target: AnyObject!, action: Selector) -> UIButton {
        var ret = UIButton.buttonWithType(.Custom) as! UIButton
        ret.setTitle(title, forState: .Normal)
        ret.setTitleColor(UIColor.redColor(), forState: .Normal)
        ret.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return ret
    }
    
}



