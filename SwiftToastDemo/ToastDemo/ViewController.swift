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
        
        let longToastBtn = quickAddButtonWithTitle("Long Toast", target: self, action: #selector(ViewController.handleLongMessageToastClicked(_:)))
        longToastBtn.frame = CGRect(x: MarginX, y: 3*MarginY + ButtonHeight, width: ButtonWidth, height: ButtonHeight)
        view.addSubview(longToastBtn)
        
        let titleToastBtn    = quickAddButtonWithTitle("Title Toast", target: self, action: #selector(ViewController.handleTitleToastClicked(_:)))
        titleToastBtn.frame  = CGRect(x: MarginX, y: 4*MarginY + 2*ButtonHeight, width: ButtonWidth, height: ButtonHeight)
        view.addSubview(titleToastBtn)
        
        let largeImageToastBtn    = quickAddButtonWithTitle("Large Image Toast", target: self, action: #selector(ViewController.handleLargeImageToastClicked(_:)))
        largeImageToastBtn.frame  = CGRect(x: MarginX, y: 5*MarginY + 3*ButtonHeight, width: ButtonWidth, height: ButtonHeight)
        view.addSubview(largeImageToastBtn)
        
        let smallImageToastBtn    = quickAddButtonWithTitle("Small Image Toast", target: self, action: #selector(ViewController.handleSmallImageToastClicked(_:)))
        smallImageToastBtn.frame  = CGRect(x: MarginX, y: 6*MarginY + 4*ButtonHeight, width: ButtonWidth, height: ButtonHeight)
        view.addSubview(smallImageToastBtn)
        
        let showActivityBtn   = quickAddButtonWithTitle("Show Activity", target: self, action: #selector(ViewController.showActivity))
        showActivityBtn.frame = CGRect(x: MarginX, y: 7*MarginY + 5*ButtonHeight, width: ButtonWidth, height: ButtonHeight)
        view.addSubview(showActivityBtn)
        
        let showMsgActivityBtn = quickAddButtonWithTitle("Show Activity With Message", target: self, action: #selector(ViewController.showActivityWithMessage))
        showMsgActivityBtn.frame = CGRect(x: MarginX, y: 8*MarginY + 6*ButtonHeight, width: ButtonWidth, height: ButtonHeight)
        view.addSubview(showMsgActivityBtn)
        
        let hideActivityBtn   = quickAddButtonWithTitle("Hide Activity", target: self, action: #selector(ViewController.hideActivity))
        hideActivityBtn.frame = CGRect(x: MarginX, y: UIScreen.main.bounds.size.height - ButtonHeight - MarginY - 100, width: ButtonWidth, height: ButtonHeight)
        view.addSubview(hideActivityBtn)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // handle events
    @objc func handleSingleToastClicked(_ sender: UIButton) {
        presentWindow!.makeToast(message: sender.title(for: UIControlState())!)
    }
    
    @objc func handleLongMessageToastClicked(_ sender: UIButton) {
        view.makeToast(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum porttitor, nisl ut bibendum vestibulum, sem purus tempor arcu, quis aliquet diam eros non justo. Integer et est vel magna sagittis ultrices. Sed non convallis nisl, in fermentum odio. Sed quis leo congue, dapibus diam ut, dictum risus. Nullam feugiat erat eget magna bibendum, non luctus lacus mollis.", duration: 2, position: "bottom" as AnyObject)
    }
    
    @objc func handleTitleToastClicked(_ sender: UIButton) {
        view.makeToast(message: sender.title(for: UIControlState())!, duration: 2, position: HRToastPositionTop as AnyObject, title: "<Title>")
    }
    
    @objc func handleLargeImageToastClicked(_ sender: UIButton) {
        let image = UIImage(named: "swift-logo.png")
        presentWindow!.makeToast(message: sender.title(for: UIControlState())!, duration: 2, position: "center" as AnyObject, title: "Large Image!", image: image!)
    }
    
    @objc func handleSmallImageToastClicked(_ sender: UIButton) {
        let image = UIImage(named: "small-image")
        presentWindow!.makeToast(message: sender.title(for: UIControlState())!, duration: 2, position: "center" as AnyObject, title: "Small Image!", image: image!)
    }
    
    @objc func showActivity() {
        presentWindow!.makeToastActivity()
    }
    
    @objc func showActivityWithMessage() {
        presentWindow!.makeToastActivity(message: "Loading...")
    }
    
    @objc func hideActivity() {
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



