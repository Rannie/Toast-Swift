//
//  HRToast + UIView.swift
//  ToastDemo
//
//  Created by Rannie on 14/7/6.
//  Copyright (c) 2014年 Rannie. All rights reserved.
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
let HRToastShadowOffset   : CGSize    = CGSizeMake(CGFloat(4.0), CGFloat(4.0))

let HRToastOpacity        : CGFloat   = 0.8
let HRToastCornerRadius   : CGFloat   = 10.0

var HRToastActivityView: UnsafePointer<UIView>    =   nil
var HRToastTimer: UnsafePointer<NSTimer>          =   nil
var HRToastView: UnsafePointer<UIView>            =   nil

/*
*  Custom Config
*/
let HRToastHidesOnTap       =   true
let HRToastDisplayShadow    =   true

//HRToast (UIView + Toast using Swift)

extension UIView {
    
    /*
    *  public methods
    */
    func makeToast(message msg: String) {
        self.makeToast(message: msg, duration: HRToastDefaultDuration, position: HRToastPositionDefault)
    }
    
    func makeToast(message msg: String, duration: Double, position: AnyObject) {
        var toast = self.viewForMessage(msg, title: nil, image: nil)
        self.showToast(toast: toast!, duration: duration, position: position)
    }
    
    func makeToast(message msg: String, duration: Double, position: AnyObject, title: String) {
        var toast = self.viewForMessage(msg, title: title, image: nil)
        self.showToast(toast: toast!, duration: duration, position: position)
    }
    
    func makeToast(message msg: String, duration: Double, position: AnyObject, image: UIImage) {
        var toast = self.viewForMessage(msg, title: nil, image: image)
        self.showToast(toast: toast!, duration: duration, position: position)
    }
    
    func makeToast(message msg: String, duration: Double, position: AnyObject, title: String, image: UIImage) {
        var toast = self.viewForMessage(msg, title: title, image: image)
        self.showToast(toast: toast!, duration: duration, position: position)
    }
    
    func showToast(#toast: UIView) {
        self.showToast(toast: toast, duration: HRToastDefaultDuration, position: HRToastPositionDefault)
    }
    
    func showToast(#toast: UIView, duration: Double, position: AnyObject) {
        var existToast = objc_getAssociatedObject(self, &HRToastView) as! UIView?
        if existToast != nil {
            if let timer: NSTimer = objc_getAssociatedObject(existToast, &HRToastTimer) as? NSTimer {
                timer.invalidate();
            }
            self.hideToast(toast: existToast!, force: false);
        }
        
        toast.center = self.centerPointForPosition(position, toast: toast)
        toast.alpha = 0.0
        
        if HRToastHidesOnTap {
            var tapRecognizer = UITapGestureRecognizer(target: toast, action: Selector("handleToastTapped:"))
            toast.addGestureRecognizer(tapRecognizer)
            toast.userInteractionEnabled = true;
            toast.exclusiveTouch = true;
        }
        
        self.addSubview(toast)
        objc_setAssociatedObject(self, &HRToastView, toast, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        
        UIView.animateWithDuration(HRToastFadeDuration,
            delay: 0.0, options: (.CurveEaseOut | .AllowUserInteraction),
            animations: {
                toast.alpha = 1.0
            },
            completion: { (finished: Bool) in
                var timer = NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: Selector("toastTimerDidFinish:"), userInfo: toast, repeats: false)
                objc_setAssociatedObject(toast, &HRToastTimer, timer, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        })
    }
    
    func makeToastActivity() {
        self.makeToastActivity(position: HRToastActivityPositionDefault)
    }

    func makeToastActivityWithMessage(message msg: String){
        self.makeToastActivity(position: HRToastActivityPositionDefault, message: msg)
    }
    
    func makeToastActivity(position pos: AnyObject, message msg: String = "") {
        var existingActivityView: UIView? = objc_getAssociatedObject(self, &HRToastActivityView) as? UIView
        if existingActivityView != nil { return }
        
        var activityView = UIView(frame: CGRectMake(0, 0, HRToastActivityWidth, HRToastActivityHeight))
        activityView.center = self.centerPointForPosition(pos, toast: activityView)
        activityView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(HRToastOpacity)
        activityView.alpha = 0.0
        activityView.autoresizingMask = (.FlexibleLeftMargin | .FlexibleTopMargin | .FlexibleRightMargin | .FlexibleBottomMargin)
        activityView.layer.cornerRadius = HRToastCornerRadius
        
        if HRToastDisplayShadow {
            activityView.layer.shadowColor = UIColor.blackColor().CGColor
            activityView.layer.shadowOpacity = Float(HRToastShadowOpacity)
            activityView.layer.shadowRadius = HRToastShadowRadius
            activityView.layer.shadowOffset = HRToastShadowOffset
        }
        
        var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        activityIndicatorView.center = CGPointMake(activityView.bounds.size.width / 2, activityView.bounds.size.height / 2)
        activityView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        if (!msg.isEmpty){
            activityIndicatorView.frame.origin.y -= 10
            var activityMessageLabel = UILabel(frame: CGRectMake(activityView.bounds.origin.x, (activityIndicatorView.frame.origin.y + activityIndicatorView.frame.size.height + 10), activityView.bounds.size.width, 20))
            activityMessageLabel.textColor = UIColor.whiteColor()
            activityMessageLabel.font = (count(msg)<=10) ? UIFont(name:activityMessageLabel.font.fontName, size: 16) : UIFont(name:activityMessageLabel.font.fontName, size: 13)
            activityMessageLabel.textAlignment = .Center
            activityMessageLabel.text = msg
            activityView.addSubview(activityMessageLabel)
        }

        self.addSubview(activityView)
        
        // associate activity view with self
        objc_setAssociatedObject(self, &HRToastActivityView, activityView, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        
        UIView.animateWithDuration(HRToastFadeDuration,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                activityView.alpha = 1.0
            },
            completion: nil)
    }
    
    func hideToastActivity() {
        var existingActivityView = objc_getAssociatedObject(self, &HRToastActivityView) as! UIView?
        if existingActivityView == nil { return }
        UIView.animateWithDuration(HRToastFadeDuration,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                existingActivityView!.alpha = 0.0
            },
            completion: { (finished: Bool) in
                existingActivityView!.removeFromSuperview()
                objc_setAssociatedObject(self, &HRToastActivityView, nil, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        })
    }
    
    /*
    *  private methods (helper)
    */
    func hideToast(#toast: UIView) {
        self.hideToast(toast: toast, force: false);
    }
    
    func hideToast(#toast: UIView, force: Bool) {
        var completeClosure = { (finish: Bool) -> () in
            toast.removeFromSuperview()
            objc_setAssociatedObject(self, &HRToastTimer, nil, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
        
        if force {
            completeClosure(true)
        } else {
            UIView.animateWithDuration(HRToastFadeDuration,
                delay: 0.0,
                options: (.CurveEaseIn | .BeginFromCurrentState),
                animations: {
                    toast.alpha = 0.0
                },
                completion:completeClosure)
        }
    }
    
    func toastTimerDidFinish(timer: NSTimer) {
        self.hideToast(toast: timer.userInfo as! UIView)
    }
    
    func handleToastTapped(recognizer: UITapGestureRecognizer) {
        var timer = objc_getAssociatedObject(self, &HRToastTimer) as! NSTimer
        timer.invalidate()
        
        self.hideToast(toast: recognizer.view!)
    }
    
    func centerPointForPosition(position: AnyObject, toast: UIView) -> CGPoint {
        if position is String {
            var toastSize = toast.bounds.size
            var viewSize  = self.bounds.size
            if position.lowercaseString == HRToastPositionTop {
                return CGPointMake(viewSize.width/2, toastSize.height/2 + HRToastVerticalMargin)
            } else if position.lowercaseString == HRToastPositionDefault {
                return CGPointMake(viewSize.width/2, viewSize.height - toastSize.height/2 - HRToastVerticalMargin)
            } else if position.lowercaseString == HRToastPositionCenter {
                return CGPointMake(viewSize.width/2, viewSize.height/2)
            }
        } else if position is NSValue {
            return position.CGPointValue()
        }
        
        println("Warning: Invalid position for toast.")
        return self.centerPointForPosition(HRToastPositionDefault, toast: toast)
    }
    
    func viewForMessage(msg: String?, title: String?, image: UIImage?) -> UIView? {
        if msg == nil && title == nil && image == nil { return nil }
        
        var msgLabel: UILabel?
        var titleLabel: UILabel?
        var imageView: UIImageView?
        
        var wrapperView = UIView()
        wrapperView.autoresizingMask = (.FlexibleLeftMargin | .FlexibleRightMargin | .FlexibleTopMargin | .FlexibleBottomMargin)
        wrapperView.layer.cornerRadius = HRToastCornerRadius
        wrapperView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(HRToastOpacity)
        
        if HRToastDisplayShadow {
            wrapperView.layer.shadowColor = UIColor.blackColor().CGColor
            wrapperView.layer.shadowOpacity = Float(HRToastShadowOpacity)
            wrapperView.layer.shadowRadius = HRToastShadowRadius
            wrapperView.layer.shadowOffset = HRToastShadowOffset
        }
        
        if image != nil {
            imageView = UIImageView(image: image)
            imageView!.contentMode = .ScaleAspectFit
            imageView!.frame = CGRectMake(HRToastHorizontalMargin, HRToastVerticalMargin, CGFloat(HRToastImageViewWidth), CGFloat(HRToastImageViewHeight))
        }
        
        var imageWidth: CGFloat, imageHeight: CGFloat, imageLeft: CGFloat
        if imageView != nil {
            imageWidth = imageView!.bounds.size.width
            imageHeight = imageView!.bounds.size.height
            imageLeft = HRToastHorizontalMargin
        } else {
            imageWidth  = 0.0; imageHeight = 0.0; imageLeft   = 0.0
        }
        
        if title != nil {
            titleLabel = UILabel()
            titleLabel!.numberOfLines = HRToastMaxTitleLines
            titleLabel!.font = UIFont.boldSystemFontOfSize(HRToastFontSize)
            titleLabel!.textAlignment = .Center
            titleLabel!.lineBreakMode = .ByWordWrapping
            titleLabel!.textColor = UIColor.whiteColor()
            titleLabel!.backgroundColor = UIColor.clearColor()
            titleLabel!.alpha = 1.0
            titleLabel!.text = title
            
            // size the title label according to the length of the text
            var maxSizeTitle = CGSizeMake((self.bounds.size.width * HRToastMaxWidth) - imageWidth, self.bounds.size.height * HRToastMaxHeight);
            var expectedHeight = title!.stringHeightWithFontSize(HRToastFontSize, width: maxSizeTitle.width)
            titleLabel!.frame = CGRectMake(0.0, 0.0, maxSizeTitle.width, expectedHeight)
        }
        
        if msg != nil {
            msgLabel = UILabel();
            msgLabel!.numberOfLines = HRToastMaxMessageLines
            msgLabel!.font = UIFont.systemFontOfSize(HRToastFontSize)
            msgLabel!.lineBreakMode = .ByWordWrapping
            msgLabel!.textAlignment = .Center
            msgLabel!.textColor = UIColor.whiteColor()
            msgLabel!.backgroundColor = UIColor.clearColor()
            msgLabel!.alpha = 1.0
            msgLabel!.text = msg
            
            var maxSizeMessage = CGSizeMake((self.bounds.size.width * HRToastMaxWidth) - imageWidth, self.bounds.size.height * HRToastMaxHeight)
            var expectedHeight = msg!.stringHeightWithFontSize(HRToastFontSize, width: maxSizeMessage.width)
            msgLabel!.frame = CGRectMake(0.0, 0.0, maxSizeMessage.width, expectedHeight)
        }
        
        var titleWidth: CGFloat, titleHeight: CGFloat, titleTop: CGFloat, titleLeft: CGFloat
        if titleLabel != nil {
            titleWidth = titleLabel!.bounds.size.width
            titleHeight = titleLabel!.bounds.size.height
            titleTop = HRToastVerticalMargin
            titleLeft = imageLeft + imageWidth + HRToastHorizontalMargin
        } else {
            titleWidth = 0.0; titleHeight = 0.0; titleTop = 0.0; titleLeft = 0.0
        }
        
        var msgWidth: CGFloat, msgHeight: CGFloat, msgTop: CGFloat, msgLeft: CGFloat
        if msgLabel != nil {
            msgWidth = msgLabel!.bounds.size.width
            msgHeight = msgLabel!.bounds.size.height
            msgTop = titleTop + titleHeight + HRToastVerticalMargin
            msgLeft = imageLeft + imageWidth + HRToastHorizontalMargin
        } else {
            msgWidth = 0.0; msgHeight = 0.0; msgTop = 0.0; msgLeft = 0.0
        }
        
        var largerWidth = max(titleWidth, msgWidth)
        var largerLeft  = max(titleLeft, msgLeft)
        
        // set wrapper view's frame
        var wrapperWidth  = max(imageWidth + HRToastHorizontalMargin * 2, largerLeft + largerWidth + HRToastHorizontalMargin)
        var wrapperHeight = max(msgTop + msgHeight + HRToastVerticalMargin, imageHeight + HRToastVerticalMargin * 2)
        wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight)
        
        // add subviews
        if titleLabel != nil {
            titleLabel!.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight)
            wrapperView.addSubview(titleLabel!)
        }
        if msgLabel != nil {
            msgLabel!.frame = CGRectMake(msgLeft, msgTop, msgWidth, msgHeight)
            wrapperView.addSubview(msgLabel!)
        }
        if imageView != nil {
            wrapperView.addSubview(imageView!)
        }
        
        return wrapperView
    }
    
}

extension String {
    
    func stringHeightWithFontSize(fontSize: CGFloat,width: CGFloat) -> CGFloat {
        var font = UIFont.systemFontOfSize(fontSize)
        var size = CGSizeMake(width, CGFloat.max)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .ByWordWrapping;
        var attributes = [NSFontAttributeName:font,
            NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        var text = self as NSString
        var rect = text.boundingRectWithSize(size, options:.UsesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }
    
}


