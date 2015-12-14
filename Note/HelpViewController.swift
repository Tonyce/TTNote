//
//  HelpViewController.swift
//  Note
//
//  Created by D_ttang on 15/12/9.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    weak var delegate: LeftMenuProtocol?
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeBtn.backgroundColor = UIColor.clearColor()
        closeBtn.titleLabel?.font = UIFont(name: "googleicon", size: 21)
        closeBtn.setTitle(GoogleIcon.ebd0, forState: UIControlState.Normal)
        
        menuBtn.backgroundColor = UIColor.clearColor()
        menuBtn.titleLabel?.font = UIFont(name: "googleicon", size: 22)
        menuBtn.setTitle(GoogleIcon.ea6d, forState: UIControlState.Normal)
        
        var htmlStr = ""
        let path = NSBundle.mainBundle().pathForResource("help", ofType: "html")
        // print(path)
        do {
            htmlStr = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        }catch _ {}
        webView.loadHTMLString(htmlStr, baseURL: NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath))
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
}
