//
//  FeedBackViewController.swift
//  Note
//
//  Created by D_ttang on 15/12/9.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {
    weak var delegate: LeftMenuProtocol?
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        closeBtn.backgroundColor = UIColor.clearColor()
        closeBtn.titleLabel?.font = UIFont(name: "googleicon", size: 21)
        closeBtn.setTitle(GoogleIcon.ebd0, forState: UIControlState.Normal)
        
        menuBtn.backgroundColor = UIColor.clearColor()
        menuBtn.titleLabel?.font = UIFont(name: "googleicon", size: 22)
        menuBtn.setTitle(GoogleIcon.ea6d, forState: UIControlState.Normal)
        
        
        cancelBtn.tintColor = UIColor.whiteColor()
        okBtn.tintColor = UIColor.whiteColor()
        cancelBtn.backgroundColor = UIColor.MKColor.LightBlue
        okBtn.backgroundColor = UIColor.MKColor.LightBlue
        cancelBtn.setCircleRadius()
        okBtn.setCircleRadius()
        
        scrollView.keyboardDismissMode = .Interactive

    }
    
    override func viewWillAppear(animated: Bool) {
        textView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menu(sender: AnyObject) {
        self.slideMenuController()?.toggleLeft()
    }

    @IBAction func close(sender: AnyObject) {
        delegate?.changeViewController(LeftMenu.Note)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
