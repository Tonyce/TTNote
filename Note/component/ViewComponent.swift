//
//  ViewComponent.swift
//  NoSingle
//
//  Created by D_ttang on 15/11/8.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation
import UIKit

class selfLoadingView: UIView {
    
    let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
    let kMMRingStrokeAnimationKey = "mmmaterialdesignspinner.stroke"
    let kMMRingRotationAnimationKey = "mmmaterialdesignspinner.rotation"
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.MKColor.LightBlue.setFill()
        path.fill()
    }
    
    override init(frame: CGRect = CGRectZero) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.setShadow()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addToSuperView(superView: UIView, aboveView: UIView) {
        self.frame.size.width = 50
        self.frame.size.height = 50
        self.center.x = superView.center.x
        self.center.y = -100
        superView.insertSubview(self, aboveSubview: aboveView)
        addMMSpinner(self)
    }
    
    func showToSuperView(y: CGFloat = 150) {
        self.beginRefreshing()
        UIView.animateWithDuration(0.5,
            animations: {
                self.center.y = y
            }, completion: {
                _ in
        })
    }
    
    func hidenFromSuperview() {
        UIView.animateWithDuration(0.5,
            animations: {
                self.center.y = -100
            }, completion: {
                _ in
                self.stopAnimate()
        })
    }
    
    func addMMSpinner(superView: UIView){
        
        ovalShapeLayer.strokeColor = UIColor.whiteColor().CGColor
        ovalShapeLayer.fillColor = UIColor.clearColor().CGColor
        ovalShapeLayer.lineWidth = 3.0
        ovalShapeLayer.frame = CGRectMake(0, 0, superView.frame.width, superView.frame.height)
        //        ovalShapeLayer.backgroundColor = UIColor.orangeColor().CGColor
        let refreshRadius = superView.frame.size.height/2 * 0.5
        let path = UIBezierPath(ovalInRect: CGRect(
            x: superView.frame.size.width/2 - refreshRadius,
            y: superView.frame.size.height/2 - refreshRadius,
            width: 2 * refreshRadius,
            height: 2 * refreshRadius))
        
        ovalShapeLayer.path = path.CGPath
        superView.layer.addSublayer(ovalShapeLayer)

    }
    
    func beginRefreshing() {
        
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation"
        animation.duration = 4.0;
        animation.fromValue = 0.0;
        animation.toValue = 2 * M_PI;
        animation.repeatCount = Float.infinity
        
        ovalShapeLayer.addAnimation(animation, forKey: kMMRingRotationAnimationKey)
        
        let headAnimation = CABasicAnimation()
        headAnimation.keyPath = "strokeStart"
        headAnimation.duration = 1.0;
        headAnimation.fromValue = 0.0;
        headAnimation.toValue = 0.25;
        
        
        let tailAnimation = CABasicAnimation()
        tailAnimation.keyPath = "strokeEnd"
        tailAnimation.duration = 1.0
        tailAnimation.fromValue = 0.0
        tailAnimation.toValue = 1.0
        tailAnimation.delegate = self
        
        
        let endHeadAnimation = CABasicAnimation()
        endHeadAnimation.keyPath = "strokeStart"
        endHeadAnimation.beginTime = 1.0
        endHeadAnimation.duration = 0.5
        endHeadAnimation.fromValue = 0.25
        endHeadAnimation.toValue = 1.0
        
        let endTailAnimation = CABasicAnimation()
        endTailAnimation.keyPath = "strokeEnd"
        endTailAnimation.beginTime = 1.0
        endTailAnimation.duration = 0.5
        endTailAnimation.fromValue = 1.0
        endTailAnimation.toValue = 1.0
        
        let animations = CAAnimationGroup()
        animations.duration = 1.5
        animations.animations = [headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]
        animations.repeatCount = Float.infinity
        ovalShapeLayer.addAnimation(animations, forKey: kMMRingStrokeAnimationKey)
    }
    
    func stopAnimate(){
        ovalShapeLayer.removeAnimationForKey(kMMRingRotationAnimationKey)
        ovalShapeLayer.removeAnimationForKey(kMMRingStrokeAnimationKey)
    }


    func addBlurView(superView: UIView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame.size = CGSize(width: superView.bounds.width, height: superView.bounds.height)
        blurView.center = superView.center
        self.addSubview(blurView)
    }
    
    func addBG(superView: UIView) {
        self.backgroundColor = UIColor.greenColor()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = superView.bounds
        
        let color1 = UIColor.yellowColor().CGColor as CGColorRef
        let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0).CGColor as CGColorRef
        let color3 = UIColor.clearColor().CGColor as CGColorRef
        let color4 = UIColor(white: 0.0, alpha: 0.7).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2, color3, color4]
        
        gradientLayer.locations = [0.0, 0.25, 0.75, 1.0]
        
        self.layer.addSublayer(gradientLayer)
    }
    
}

extension UIView {
    
    func addCircleLayer(withColor color: UIColor, lineWidth: CGFloat = 6.0, bounds: CGRect) {
        let lineWidth: CGFloat = lineWidth
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalInRect: bounds).CGPath
        circleLayer.strokeColor = color.CGColor
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clearColor().CGColor
        self.layer.addSublayer(circleLayer)
    }
    
    func setShadow() {
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset  = CGSize(width: 1, height: 1.5)
        self.layer.shadowColor   = UIColor.blackColor().CGColor
//         self.layer.shadowRadius  = 5.0
    }
    
    func removeShadow() {
        self.layer.shadowOpacity = 0.0
        self.layer.shadowOffset  = CGSizeZero
        self.layer.shadowColor   = UIColor.whiteColor().CGColor
        self.layer.shadowRadius  = 0
    }
    
    func setRadius(radius: CGFloat ) {
        self.layer.cornerRadius = radius
        // self.layer.masksToBounds = true
    }
    
    func setCircleRadius() {
        let radius = CGRectGetHeight(self.frame) / 2
        setRadius(radius)
    }
    
    func setConstraints(container: UIView, top: CGFloat = -60) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let leading = NSLayoutConstraint(item: self,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1,
            constant: -4)
        container.addConstraint(leading)
        
        let top = NSLayoutConstraint(item: self,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1,
            constant: top)
        container.addConstraint(top)
        
        let bottom = NSLayoutConstraint(item: self,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1,
            constant: 0)
        container.addConstraint(bottom)
        
        let trailing = NSLayoutConstraint(item: self,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1,
            constant: 4)
        container.addConstraint(trailing)
    }
}

extension UIView {
    // not work
//    var parentViewController: UIViewController? {
//        var parentResponder: UIResponder? = self
//        while parentResponder != nil {
//            parentResponder = parentResponder!.nextResponder()
//            if let viewController = parentResponder as? UIViewController {
//                return viewController
//            }
//        }
//        return nil
//    }
}

//extension UIViewController {
//    func displayAlert(message: String){
//        let alertController = UIAlertController(title: "发生点小意外", message: message, preferredStyle: UIAlertControllerStyle.Alert)
//        alertController.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default,handler: {
//            _ in
//        }))
//        // self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
//        self.presentViewController(alertController, animated: true, completion: nil)
//    }
//}