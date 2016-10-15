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
let MarginX      = (UIScreen.main.bounds.size.width - ButtonWidth) / 2
let ThemeColor   = UIColor(red: 255/255.0, green: 163/255.0, blue: 0/255.0, alpha: 1.0)

class ViewController: UIViewController {
    
    var presentWindow : UIWindow?
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swift Toast"
        edgesForExtendedLayout = UIRectEdge()
        UIView.hr_setToastThemeColor(color: ThemeColor)
        presentWindow = UIApplication.shared.keyWindow
        setupButtons()
    }
    
    func setupButtons() {
        let singleToastBtn   = quickAddButtonWithTitle("Single Toast", target: self, action: #selector(ViewController.handleSingleToastClicked(_:)))
        singleToastBtn.frame = CGRect(x: MarginX, y: 2*MarginY, width: ButtonWidth, height: ButtonHeight)
        view.addSubview(singleToastBtn)
        
        let titleToastBtn    = quickAddButtonWithTitle("Title Toast", target: self, action: #selector(ViewController.handleTitleToastClicked(_:)))
        titleToastBtn.frame  = CGRect(x: MarginX, y: 3*MarginY + ButtonHeight, width: ButtonWidth, height: ButtonHeight)
        view.addSubview(titleToastBtn)
        
        let imageToastBtn    = quickAddButtonWithTitle("Image Toast", target: self, action: #selector(ViewController.handleImageToastClicked(_:)))
        imageToastBtn.frame  = CGRect(x: MarginX, y: 4*MarginY + 2*ButtonHeight, width: ButtonWidth, height: ButtonHeight)
        view.addSubview(imageToastBtn)
        
        let showActivityBtn   = quickAddButtonWithTitle("Show Activity", target: self, action: #selector(ViewController.showActivity))
        showActivityBtn.frame = CGRect(x: MarginX, y: 5*MarginY + 3*ButtonHeight, width: ButtonWidth, height: ButtonHeight)
        view.addSubview(showActivityBtn)
        
        let showMsgActivityBtn = quickAddButtonWithTitle("Show Activity With Message", target: self, action: #selector(ViewController.showActivityWithMessage))
        showMsgActivityBtn.frame = CGRect(x: MarginX, y: 6*MarginY + 4*ButtonHeight, width: ButtonWidth, height: ButtonHeight)
        view.addSubview(showMsgActivityBtn)
        
        let hideActivityBtn   = quickAddButtonWithTitle("Hide Activity", target: self, action: #selector(ViewController.hideActivity))
        hideActivityBtn.frame = CGRect(x: MarginX, y: UIScreen.main.bounds.size.height - ButtonHeight - MarginY - 64, width: ButtonWidth, height: ButtonHeight)
        view.addSubview(hideActivityBtn)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // handle events
    func handleSingleToastClicked(_ sender: UIButton) {
        presentWindow!.makeToast(message: sender.title(for: UIControlState())!)
    }
    
    func handleTitleToastClicked(_ sender: UIButton) {
        view.makeToast(message: sender.title(for: UIControlState())!, duration: 2, position: HRToastPositionTop as AnyObject, title: "<Title>")
    }
    
    func handleImageToastClicked(_ sender: UIButton) {
        let image = UIImage(named: "swift-logo.png")
        presentWindow!.makeToast(message: sender.title(for: UIControlState())!, duration: 2, position: "center" as AnyObject, title: "Image!", image: image!)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presentWindow!.hideToastActivity()
    }
    
    // ui helper
    func quickAddButtonWithTitle(_ title: String, target: AnyObject!, action: Selector) -> UIButton {
        let ret = UIButton(type: .custom)
        ret.setTitle(title, for: UIControlState())
        ret.setTitleColor(ThemeColor, for: UIControlState())
        ret.addTarget(target, action: action, for: .touchUpInside)
        return ret
    }
    
}



