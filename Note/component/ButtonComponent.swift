//
//  ButtonComponent.swift
//  NoSingle
//
//  Created by D_ttang on 15/11/7.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

@IBDesignable
class AddButton: UIButton {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.redColor().setFill()
//        UIColor.clearColor().setFill()
        path.fill()
        
        let plusHeight:CGFloat = 2.0
        let plusWidth:CGFloat  = min(bounds.width, bounds.height) * 0.5
        
        let plusPath = UIBezierPath()
        
        plusPath.lineWidth = plusHeight
        
        plusPath.moveToPoint(CGPoint(x: bounds.width / 2 - plusWidth / 2 + 0.5 , y: bounds.height / 2 + 0.5))
        plusPath.addLineToPoint(CGPoint(x: bounds.width / 2 + plusWidth / 2 + 0.5 , y: bounds.height / 2 + 0.5))
        
        plusPath.moveToPoint(CGPoint(x: bounds.width / 2 + 0.5, y: bounds.height / 2 - plusWidth / 2 + 0.5))
        plusPath.addLineToPoint(CGPoint(x: bounds.width / 2 + 0.5, y: bounds.height / 2 + plusWidth / 2 + 0.5))
        
        
        UIColor.whiteColor().setStroke()
        plusPath.stroke()
        
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset  = CGSize(width: 0, height: 1.5)
//        self.layer.shadowColor   = UIColor.blackColor().CGColor
//        self.layer.shadowRadius  = 10.0
    }
    
}