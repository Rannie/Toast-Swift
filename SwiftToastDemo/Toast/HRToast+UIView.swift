//
//  HRToast + UIView.swift
//  ToastDemo
//
//  Created by Rannie on 14/7/6.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//  https://github.com/Rannie/Toast-Swift
//

import UIKit

/*
 *  Infix overload method
 */
func /(lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs / CGFloat(rhs)
}

/*
 *  Toast Config
 */
let HRToastDefaultDuration  =   2.0
let HRToastFadeDuration     =   0.2
let HRToastHorizontalMargin : CGFloat  =   10.0
let HRToastVerticalMargin   : CGFloat  =   10.0

let HRToastPositionDefault  =   "bottom"
let HRToastPositionTop      =   "top"
let HRToastPositionCenter   =   "center"

// activity
let HRToastActivityWidth  :  CGFloat  = 100.0
let HRToastActivityHeight :  CGFloat  = 100.0
let HRToastActivityPositionDefault    = "center"

// image size
let HRToastImageViewWidth :  CGFloat  = 80.0
let HRToastImageViewHeight:  CGFloat  = 80.0

// label setting
let HRToastMaxWidth       :  CGFloat  = 0.8;      // 80% of parent view width
let HRToastMaxHeight      :  CGFloat  = 0.8;
let HRToastFontSize       :  CGFloat  = 16.0
let HRToastMaxTitleLines              = 0
let HRToastMaxMessageLines            = 0

// shadow appearance
let HRToastShadowOpacity  : CGFloat   = 0.8
let HRToastShadowRadius   : CGFloat   = 6.0
let HRToastShadowOffset   : CGSize    = CGSize(width: CGFloat(4.0), height: CGFloat(4.0))

let HRToastOpacity        : CGFloat   = 0.9
let HRToastCornerRadius   : CGFloat   = 10.0

var HRToastActivityView: UnsafePointer<UIView>?    =   nil
var HRToastTimer: UnsafePointer<Timer>?          =   nil
var HRToastView: UnsafePointer<UIView>?            =   nil
var HRToastThemeColor : UnsafePointer<UIColor>?    =   nil
var HRToastTitleFontName: UnsafePointer<String>?   =   nil
var HRToastFontName: UnsafePointer<String>?        =   nil
var HRToastFontColor: UnsafePointer<UIColor>?      =   nil

/*
 *  Custom Config
 */
let HRToastHidesOnTap       =   true
let HRToastDisplayShadow    =   true

//HRToast (UIView + Toast using Swift)

public extension UIView {
    
    /*
     *  public methods
     */
    class func hr_setToastThemeColor(color: UIColor) {
        objc_setAssociatedObject(self, &HRToastThemeColor, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    class func hr_toastThemeColor() -> UIColor {
        var color = objc_getAssociatedObject(self, &HRToastThemeColor) as! UIColor?
        if color == nil {
            color = UIColor.black
            UIView.hr_setToastThemeColor(color: color!)
        }
        return color!
    }
    
    class func hr_setToastTitleFontName(fontName: String) {
        objc_setAssociatedObject(self, &HRToastTitleFontName, fontName, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    class func hr_toastTitleFontName() -> String {
        var name = objc_getAssociatedObject(self, &HRToastTitleFontName) as! String?
        if name == nil {
            let font = UIFont.systemFont(ofSize: 12.0)
            name = font.fontName
            UIView.hr_setToastTitleFontName(fontName: name!)
        }
        
        return name!
    }
    
    class func hr_setToastFontName(fontName: String) {
        objc_setAssociatedObject(self, &HRToastFontName, fontName, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    class func hr_toastFontName() -> String {
        var name = objc_getAssociatedObject(self, &HRToastFontName) as! String?
        if name == nil {
            let font = UIFont.systemFont(ofSize: 12.0)
            name = font.fontName
            UIView.hr_setToastFontName(fontName: name!)
        }
        
        return name!
    }
    
    class func hr_setToastFontColor(color: UIColor) {
        objc_setAssociatedObject(self, &HRToastFontColor, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    class func hr_toastFontColor() -> UIColor {
        var color = objc_getAssociatedObject(self, &HRToastFontColor) as! UIColor?
        if color == nil {
            color = UIColor.white
            UIView.hr_setToastFontColor(color: color!)
        }
        
        return color!
    }
    
    func makeToast(message msg: String) {
        makeToast(message: msg, duration: HRToastDefaultDuration, position: HRToastPositionDefault as AnyObject)
    }
    
    func makeToast(message msg: String, duration: Double, position: AnyObject) {
        let toast = self.viewForMessage(msg, title: nil, image: nil)
        showToast(toast: toast!, duration: duration, position: position)
    }
    
    func makeToast(message msg: String, duration: Double, position: AnyObject, title: String) {
        let toast = self.viewForMessage(msg, title: title, image: nil)
        showToast(toast: toast!, duration: duration, position: position)
    }
    
    func makeToast(message msg: String, duration: Double, position: AnyObject, image: UIImage) {
        let toast = self.viewForMessage(msg, title: nil, image: image)
        showToast(toast: toast!, duration: duration, position: position)
    }
    
    func makeToast(message msg: String, duration: Double, position: AnyObject, title: String, image: UIImage) {
        let toast = self.viewForMessage(msg, title: title, image: image)
        showToast(toast: toast!, duration: duration, position: position)
    }
    
    func showToast(toast: UIView) {
        showToast(toast: toast, duration: HRToastDefaultDuration, position: HRToastPositionDefault as AnyObject)
    }
    
    fileprivate func showToast(toast: UIView, duration: Double, position: AnyObject) {
        let existToast = objc_getAssociatedObject(self, &HRToastView) as! UIView?
        if existToast != nil {
            if let timer: Timer = objc_getAssociatedObject(existToast, &HRToastTimer) as? Timer {
                timer.invalidate()
            }
            hideToast(toast: existToast!, force: false);
            print("hide exist!")
        }
        
        toast.alpha = 0.0
        
        if HRToastHidesOnTap {
            let tapRecognizer = UITapGestureRecognizer(target: toast, action: #selector(UIView.handleToastTapped(_:)))
            toast.addGestureRecognizer(tapRecognizer)
            toast.isUserInteractionEnabled = true;
            toast.isExclusiveTouch = true;
        }
        
        addSubview(toast)
        let desiredSize = toast.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        let sidePadding = self.bounds.width * (1 - HRToastMaxWidth) / 2
        toast.leftAnchor.constraint(equalTo: self.leftAnchor, constant: sidePadding).isActive = true
        toast.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -sidePadding).isActive = true
        toast.heightAnchor.constraint(equalToConstant: desiredSize.height).isActive = true
        let yPosition = yPositionForToastPosition(position, toastSize: desiredSize)
        toast.centerYAnchor.constraint(equalTo: self.topAnchor, constant: yPosition).isActive = true
        objc_setAssociatedObject(self, &HRToastView, toast, .OBJC_ASSOCIATION_RETAIN)
        
        UIView.animate(withDuration: HRToastFadeDuration,
                       delay: 0.0, options: ([.curveEaseOut, .allowUserInteraction]),
                       animations: {
                        toast.alpha = 1.0
        },
                       completion: { (finished: Bool) in
                        let timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(UIView.toastTimerDidFinish(_:)), userInfo: toast, repeats: false)
                        objc_setAssociatedObject(toast, &HRToastTimer, timer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        })
    }
    
    func makeToastActivity() {
        makeToastActivity(position: HRToastActivityPositionDefault as AnyObject)
    }
    
    func makeToastActivity(message msg: String){
        makeToastActivity(position: HRToastActivityPositionDefault as AnyObject, message: msg)
    }
    
    fileprivate func makeToastActivity(position pos: AnyObject, message msg: String = "") {
        let existingActivityView: UIView? = objc_getAssociatedObject(self, &HRToastActivityView) as? UIView
        if existingActivityView != nil { return }
        
        let activityView = UIView(frame: CGRect(x: 0, y: 0, width: HRToastActivityWidth, height: HRToastActivityHeight))
        activityView.layer.cornerRadius = HRToastCornerRadius
        
        activityView.center = self.centerPointForPosition(pos, toast: activityView)
        activityView.backgroundColor = UIView.hr_toastThemeColor().withAlphaComponent(HRToastOpacity)
        activityView.alpha = 0.0
        activityView.autoresizingMask = ([.flexibleLeftMargin, .flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin])
        
        if HRToastDisplayShadow {
            activityView.layer.shadowColor = UIView.hr_toastThemeColor().cgColor
            activityView.layer.shadowOpacity = Float(HRToastShadowOpacity)
            activityView.layer.shadowRadius = HRToastShadowRadius
            activityView.layer.shadowOffset = HRToastShadowOffset
        }
        
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicatorView.center = CGPoint(x: activityView.bounds.size.width / 2, y: activityView.bounds.size.height / 2)
        activityView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        if (!msg.isEmpty){
            activityIndicatorView.frame.origin.y -= 10
            let activityMessageLabel = UILabel(frame: CGRect(x: activityView.bounds.origin.x, y: (activityIndicatorView.frame.origin.y + activityIndicatorView.frame.size.height + 10), width: activityView.bounds.size.width, height: 20))
            activityMessageLabel.textColor = UIView.hr_toastFontColor()
            activityMessageLabel.font = (msg.characters.count<=10) ? UIFont(name:UIView.hr_toastFontName(), size: 16) : UIFont(name:UIView.hr_toastFontName(), size: 13)
            activityMessageLabel.textAlignment = .center
            activityMessageLabel.text = msg
            activityView.addSubview(activityMessageLabel)
        }
        
        addSubview(activityView)
        
        // associate activity view with self
        objc_setAssociatedObject(self, &HRToastActivityView, activityView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        UIView.animate(withDuration: HRToastFadeDuration,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                        activityView.alpha = 1.0
        },
                       completion: nil)
    }
    
    func hideToastActivity() {
        let existingActivityView = objc_getAssociatedObject(self, &HRToastActivityView) as! UIView?
        if existingActivityView == nil { return }
        UIView.animate(withDuration: HRToastFadeDuration,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                        existingActivityView!.alpha = 0.0
        },
                       completion: { (finished: Bool) in
                        existingActivityView!.removeFromSuperview()
                        objc_setAssociatedObject(self, &HRToastActivityView, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        })
    }
    
    /*
     *  private methods (helper)
     */
    func hideToast(toast: UIView) {
        hideToast(toast: toast, force: false);
    }
    
    func hideToast(toast: UIView, force: Bool) {
        let completeClosure = { (finish: Bool) -> () in
            toast.removeFromSuperview()
            objc_setAssociatedObject(self, &HRToastTimer, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        if force {
            completeClosure(true)
        } else {
            UIView.animate(withDuration: HRToastFadeDuration,
                           delay: 0.0,
                           options: ([.curveEaseIn, .beginFromCurrentState]),
                           animations: {
                            toast.alpha = 0.0
            },
                           completion:completeClosure)
        }
    }
    
    func toastTimerDidFinish(_ timer: Timer) {
        hideToast(toast: timer.userInfo as! UIView)
    }
    
    func handleToastTapped(_ recognizer: UITapGestureRecognizer) {
        let timer = objc_getAssociatedObject(self, &HRToastTimer) as! Timer
        timer.invalidate()
        
        hideToast(toast: recognizer.view!)
    }
    
    fileprivate func yPositionForToastPosition(_ position: AnyObject, toastSize: CGSize) -> CGFloat {
        let viewSize  = self.bounds.size
        
        if position is String {
            if position.lowercased == HRToastPositionTop {
                return toastSize.height/2 + HRToastVerticalMargin
            } else if position.lowercased == HRToastPositionDefault {
                return viewSize.height - toastSize.height/2 - HRToastVerticalMargin
            } else if position.lowercased == HRToastPositionCenter {
                return viewSize.height/2
            }
        } else if position is CGFloat {
            return position as! CGFloat
        }
        
        print("[Toast-Swift]: Warning! Invalid position for toast.")
        return viewSize.height/2
    }
    
    fileprivate func centerPointForPosition(_ position: AnyObject, toast: UIView) -> CGPoint {
        if position is String {
            let toastSize = toast.bounds.size
            let viewSize  = self.bounds.size
            if position.lowercased == HRToastPositionTop {
                return CGPoint(x: viewSize.width/2, y: toastSize.height/2 + HRToastVerticalMargin)
            } else if position.lowercased == HRToastPositionDefault {
                return CGPoint(x: viewSize.width/2, y: viewSize.height - toastSize.height/2 - HRToastVerticalMargin)
            } else if position.lowercased == HRToastPositionCenter {
                return CGPoint(x: viewSize.width/2, y: viewSize.height/2)
            }
        } else if position is NSValue {
            return position.cgPointValue
        }
        
        print("[Toast-Swift]: Warning! Invalid position for toast.")
        return self.centerPointForPosition(HRToastPositionDefault as AnyObject, toast: toast)
    }
    
    fileprivate func viewForMessage(_ msg: String?, title: String?, image: UIImage?) -> UIView? {
        if msg == nil && title == nil && image == nil { return nil }
        
        let someTextBeingShown = (msg != nil || title != nil)
        let wrapperView = createInitialView()
        let contentsStackView = addContentsStackView(toWrapperView: wrapperView)
        
        if let image = image {
            addImage(image, toStackView: contentsStackView)
        }
        
        if someTextBeingShown {
            addMessage(msg, andTitle: title, toStackView: contentsStackView)
        }
        
        return wrapperView
    }
    
    fileprivate func createInitialView() -> UIView {
        let initialView = UIView()
        initialView.translatesAutoresizingMaskIntoConstraints = false
        initialView.layer.cornerRadius = HRToastCornerRadius
        initialView.backgroundColor = UIView.hr_toastThemeColor().withAlphaComponent(HRToastOpacity)
        
        if HRToastDisplayShadow {
            initialView.layer.shadowColor = UIView.hr_toastThemeColor().cgColor
            initialView.layer.shadowOpacity = Float(HRToastShadowOpacity)
            initialView.layer.shadowRadius = HRToastShadowRadius
            initialView.layer.shadowOffset = HRToastShadowOffset
        }
        
        return initialView
    }
    
    fileprivate func addContentsStackView(toWrapperView wrapperView: UIView) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor.clear
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = HRToastVerticalMargin
        stackView.setContentHuggingPriority(1000, for: .vertical)
        stackView.setContentHuggingPriority(1000, for: .horizontal)
        
        wrapperView.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor).isActive = true
        let leftSideConstraint = stackView.leftAnchor.constraint(greaterThanOrEqualTo: wrapperView.leftAnchor, constant: HRToastHorizontalMargin)
        leftSideConstraint.priority = 1000
        leftSideConstraint.isActive = true
        let rightSideConstraint = stackView.rightAnchor.constraint(lessThanOrEqualTo: wrapperView.rightAnchor, constant: -HRToastHorizontalMargin)
        rightSideConstraint.priority = 1000
        rightSideConstraint.isActive = true
        let leftSideEqualConstraint = stackView.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: HRToastHorizontalMargin)
        leftSideEqualConstraint.priority = 250
        leftSideEqualConstraint.isActive = true
        let rightSideEqualConstraint = stackView.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -HRToastHorizontalMargin)
        rightSideEqualConstraint.priority = 250
        rightSideEqualConstraint.isActive = true
        stackView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: HRToastVerticalMargin).isActive = true
        stackView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -HRToastVerticalMargin).isActive = true
        
        return stackView
    }
    
    fileprivate func addImage(_ image: UIImage, toStackView stackView: UIStackView) {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(1000, for: .horizontal)
        imageView.setContentHuggingPriority(1000, for: .vertical)
        
        stackView.addArrangedSubview(imageView)
    }
    
    fileprivate func addMessage(_ msg: String?, andTitle title: String?, toStackView parentStackView: UIStackView) {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor.clear
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = HRToastVerticalMargin
        parentStackView.addArrangedSubview(stackView)
        
        stackView.setContentHuggingPriority(1000, for: .vertical)
        stackView.setContentHuggingPriority(1000, for: .horizontal)
        
        if let title = title {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.numberOfLines = HRToastMaxTitleLines
            titleLabel.font = UIFont(name: UIView.hr_toastFontName(), size: HRToastFontSize)
            titleLabel.textAlignment = .center
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.textColor = UIView.hr_toastFontColor()
            titleLabel.backgroundColor = UIColor.clear
            titleLabel.alpha = 1.0
            titleLabel.text = title
            
            titleLabel.setContentHuggingPriority(751, for: .vertical)
            stackView.addArrangedSubview(titleLabel)
        }
        
        if let msg = msg {
            let msgLabel = UILabel()
            msgLabel.translatesAutoresizingMaskIntoConstraints = false
            msgLabel.numberOfLines = HRToastMaxMessageLines
            msgLabel.font = UIFont(name: UIView.hr_toastFontName(), size: HRToastFontSize)
            msgLabel.lineBreakMode = .byWordWrapping
            msgLabel.textAlignment = .center
            msgLabel.textColor = UIView.hr_toastFontColor()
            msgLabel.backgroundColor = UIColor.clear
            msgLabel.alpha = 1.0
            msgLabel.text = msg
            
            msgLabel.setContentHuggingPriority(751, for: .vertical)
            stackView.addArrangedSubview(msgLabel)
        }
    }
    
}

public extension String {
    
    func stringHeightWithFontSize(_ fontSize: CGFloat,width: CGFloat) -> CGFloat {
        let font = UIFont(name: UIView.hr_toastFontName(), size: HRToastFontSize)
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes = [NSFontAttributeName:font!,
                          NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }
    
}

