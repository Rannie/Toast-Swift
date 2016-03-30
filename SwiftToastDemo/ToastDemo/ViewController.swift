//
//  ViewController.swift
//  ToastDemo
//
//  Created by Rannie on 14/7/6.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

import UIKit

let ButtonWidth  : CGFloat = 230.0
let ButtonHeight : CGFloat = 40.0
let MarginY      : CGFloat = 10.0
let MarginX      = (UIScreen.mainScreen().bounds.size.width - ButtonWidth) / 2
let ThemeColor   = UIColor(red: 255/255.0, green: 163/255.0, blue: 0/255.0, alpha: 1.0)

class ViewController: UIViewController {
    
    var presentWindow : UIWindow?
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swift Toast"
        edgesForExtendedLayout = .None
        UIView.hr_setToastThemeColor(color: ThemeColor)
        presentWindow = UIApplication.sharedApplication().keyWindow
        setupButtons()
    }
    
    func setupButtons() {
        let singleToastBtn   = self.quickAddButtonWithTitle("Single Toast", target: self, action: #selector(ViewController.handleSingleToastClicked(_:)))
        singleToastBtn.frame = CGRectMake(MarginX, 2*MarginY, ButtonWidth, ButtonHeight)
        view.addSubview(singleToastBtn)
        
        let titleToastBtn    = self.quickAddButtonWithTitle("Title Toast", target: self, action: #selector(ViewController.handleTitleToastClicked(_:)))
        titleToastBtn.frame  = CGRectMake(MarginX, 3*MarginY + ButtonHeight, ButtonWidth, ButtonHeight)
        view.addSubview(titleToastBtn)
        
        let imageToastBtn    = self.quickAddButtonWithTitle("Image Toast", target: self, action: #selector(ViewController.handleImageToastClicked(_:)))
        imageToastBtn.frame  = CGRectMake(MarginX, 4*MarginY + 2*ButtonHeight, ButtonWidth, ButtonHeight)
        view.addSubview(imageToastBtn)
        
        let showActivityBtn   = self.quickAddButtonWithTitle("Show Activity", target: self, action: #selector(ViewController.showActivity))
        showActivityBtn.frame = CGRectMake(MarginX, 5*MarginY + 3*ButtonHeight, ButtonWidth, ButtonHeight)
        view.addSubview(showActivityBtn)
        
        let showMsgActivityBtn = quickAddButtonWithTitle("Show Activity With Message", target: self, action: #selector(ViewController.showActivityWithMessage))
        showMsgActivityBtn.frame = CGRectMake(MarginX, 6*MarginY + 4*ButtonHeight, ButtonWidth, ButtonHeight)
        view.addSubview(showMsgActivityBtn)
        
        let hideActivityBtn   = self.quickAddButtonWithTitle("Hide Activity", target: self, action: #selector(ViewController.hideActivity))
        hideActivityBtn.frame = CGRectMake(MarginX, UIScreen.mainScreen().bounds.size.height - ButtonHeight - MarginY - 64, ButtonWidth, ButtonHeight)
        view.addSubview(hideActivityBtn)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // handle events
    func handleSingleToastClicked(sender: UIButton) {
        presentWindow!.makeToast(message: sender.titleForState(.Normal)!)
    }
    
    func handleTitleToastClicked(sender: UIButton) {
        view.makeToast(message: sender.titleForState(.Normal)!, duration: 2, position: HRToastPositionTop, title: "<Title>")
    }
    
    func handleImageToastClicked(sender: UIButton) {
        let image = UIImage(named: "swift-logo.png")
        presentWindow!.makeToast(message: sender.titleForState(.Normal)!, duration: 2, position: "center", title: "Image!", image: image!)
    }
    
    func showActivity() {
        presentWindow!.makeToastActivity()
    }
    
    func showActivityWithMessage() {
        presentWindow!.makeToastActivity(message: "Loading...")
    }
    
    func hideActivity() {
        presentWindow!.hideToastActivity()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        presentWindow!.hideToastActivity()
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



