//
//  EditToolBarController.swift
//  NoSingle
//
//  Created by D_ttang on 15/12/3.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class EditToolBarController: UIViewController {

    @IBOutlet weak var toolbar: UIToolbar!

    var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        toolbar.barTintColor = UIColor(red: 209 / 255, green: 213 / 255, blue: 219 / 255, alpha: 1.0)
//        textView = meEditViewController.textView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        NSBundle.mainBundle().loadNibNamed("EditToolBarController", owner: self, options: nil)
    }

    
    func moveCursor(textInput: UITextInput, direction: UITextLayoutDirection, offSet: Int){
        let range = textView.selectedTextRange
        if ((range?.empty) == true) {
            let start = textView.positionFromPosition((range?.start)!, inDirection: direction, offset: offSet)
            textView.selectedTextRange = textView.textRangeFromPosition(start!, toPosition: start!)
        }
    }
    
    @IBAction func moveLeft(sender: AnyObject) {
        self.moveCursor(textView, direction: UITextLayoutDirection.Left, offSet: 1)
    }
    
    @IBAction func moveUp(sender: AnyObject) {
        self.moveCursor(textView, direction: UITextLayoutDirection.Up, offSet: 1)
    }
    
    @IBAction func bold(sender: AnyObject) {
        let replace = "#"
        textView.replaceRange(textView.selectedTextRange!, withText: replace)
        /*
        let range = textView.selectedRange
        let string = NSMutableAttributedString(attributedString: textView.attributedText)
        
        let changedFontDescriptor = UIFont(name: ".HelveticaNeueInterface-Regular", size: 16)!
        let typ = textView.typingAttributes[NSFontAttributeName] as! UIFont
        
        let attributes = typ == changedFontDescriptor ?
        [NSFontAttributeName: UIFont.boldSystemFontOfSize(16)] :
        [NSFontAttributeName: UIFont(name: ".HelveticaNeueInterface-Regular", size: 16)!]
        string.addAttributes(attributes, range: textView.selectedRange)
        textView.attributedText = string
        textView.selectedRange = range
        */
    }
    
    @IBAction func itailc(sender: AnyObject) {
        let replace = "*"
        textView.replaceRange(textView.selectedTextRange!, withText: replace)
        /*
        let range = textView.selectedRange
        let string = NSMutableAttributedString(attributedString: textView.attributedText)
        let typ = textView.typingAttributes[NSObliquenessAttributeName] as? NSNumber
        let attributes = typ == 0.3 ? [NSObliquenessAttributeName: 0] : [NSObliquenessAttributeName: 0.3]
        string.addAttributes(attributes, range: textView.selectedRange)
        textView.attributedText = string
        textView.selectedRange = range
        let textRange = textView.selectedTextRange
        if ((textRange?.empty) == false && typ != 0.3) {
        let replace = "*\(textView.textInRange(textView.selectedTextRange!)!)*"
        textView.replaceRange(textView.selectedTextRange!, withText: replace)
        textView.replaceRange(UITextRange(), withText: replace)
        }
        */
    }
    
    @IBAction func codePre(sender: AnyObject) {
        let replace = "`"
        textView.replaceRange(textView.selectedTextRange!, withText: replace)
    }
    
    @IBAction func tab(sender: AnyObject) {
        let replace = "    "
        textView.replaceRange(textView.selectedTextRange!, withText: replace)
    }
    
    @IBAction func enter(sender: AnyObject) {
        let replace = "    \n"
        textView.replaceRange(textView.selectedTextRange!, withText: replace)
    }
    
    
    @IBAction func moveDown(sender: AnyObject) {
        self.moveCursor(textView, direction: UITextLayoutDirection.Down, offSet: 1)
    }
    
    @IBAction func moveRight(sender: AnyObject) {
        self.moveCursor(textView, direction: UITextLayoutDirection.Right, offSet: 1)
    }
    
    
    
   
  
    @IBAction func list(sender: AnyObject) {
        let range = textView.selectedRange
        let string = NSMutableAttributedString(attributedString: textView.attributedText)
        let attributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        string.addAttributes(attributes, range: textView.selectedRange)
        textView.attributedText = string
        textView.selectedRange = range
    }
}

