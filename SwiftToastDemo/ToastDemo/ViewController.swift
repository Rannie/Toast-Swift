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
let ThemeColor   = UIColor(red: 255/255.0, green: 163/255.0, blue: 0/255.0, alpha: 1.0)

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swift Toast"
        edgesForExtendedLayout = .None
        setupButtons()
        UIView.hr_setToastThemeColor(color: ThemeColor)
    }
    
    func setupButtons() {
        let singleToastBtn   = self.quickAddButtonWithTitle("Single Toast", target: self, action: Selector("handleSingleToastClicked:"))
        singleToastBtn.frame = CGRectMake(MarginX, 2*MarginY, ButtonWidth, ButtonHeight)
        view.addSubview(singleToastBtn)
        
        let titleToastBtn    = self.quickAddButtonWithTitle("Title Toast", target: self, action: Selector("handleTitleToastClicked:"))
        titleToastBtn.frame  = CGRectMake(MarginX, 3*MarginY + ButtonHeight, ButtonWidth, ButtonHeight)
        view.addSubview(titleToastBtn)
        
        let imageToastBtn    = self.quickAddButtonWithTitle("Image Toast", target: self, action: Selector("handleImageToastClicked:"))
        imageToastBtn.frame  = CGRectMake(MarginX, 4*MarginY + 2*ButtonHeight, ButtonWidth, ButtonHeight)
        view.addSubview(imageToastBtn)
        
        let showActivityBtn   = self.quickAddButtonWithTitle("Show Activity", target: self, action: Selector("showActivity"))
        showActivityBtn.frame = CGRectMake(MarginX, 5*MarginY + 3*ButtonHeight, ButtonWidth, ButtonHeight)
        view.addSubview(showActivityBtn)
        
        let hideActivityBtn   = self.quickAddButtonWithTitle("Hide Activity", target: self, action: Selector("hideActivity"))
        hideActivityBtn.frame = CGRectMake(MarginX, 6*MarginY + 4*ButtonHeight, ButtonWidth, ButtonHeight)
        view.addSubview(hideActivityBtn)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // handle events
    func handleSingleToastClicked(sender: UIButton) {
        view.makeToast(message: sender.titleForState(.Normal)!)
    }
    
    func handleTitleToastClicked(sender: UIButton) {
        view.makeToast(message: sender.titleForState(.Normal)!, duration: 2, position: HRToastPositionTop, title: "<Title>")
    }
    
    func handleImageToastClicked(sender: UIButton) {
        let image = UIImage(named: "swift-logo.png")
        view.makeToast(message: sender.titleForState(.Normal)!, duration: 2, position: "center", title: "Image!", image: image!)
    }
    
    func showActivity() {
        view.makeToastActivity()
    }
    
    func hideActivity() {
        view.hideToastActivity()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.hideToastActivity()
    }
    
    // ui helper
    func quickAddButtonWithTitle(title: String, target: AnyObject!, action: Selector) -> UIButton {
        let ret = UIButton(type: .Custom)
        ret.setTitle(title, forState: .Normal)
        ret.setTitleColor(ThemeColor, forState: .Normal)
        ret.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return ret
    }
    
}



