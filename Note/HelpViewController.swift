//
//  HelpViewController.swift
//  Note
//
//  Created by D_ttang on 15/12/9.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {

    weak var delegate: LeftMenuProtocol?
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    let wkWebView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.scrollView.contentInset.top = 66
        
        closeBtn.backgroundColor = UIColor.clearColor()
        closeBtn.titleLabel?.font = UIFont(name: "googleicon", size: 21)
        closeBtn.setTitle(GoogleIcon.ebd0, forState: UIControlState.Normal)
        
        menuBtn.backgroundColor = UIColor.clearColor()
        menuBtn.titleLabel?.font = UIFont(name: "googleicon", size: 22)
        menuBtn.setTitle(GoogleIcon.ea6d, forState: UIControlState.Normal)
        
        var mdStr = ""
        let path = NSBundle.mainBundle().pathForResource("note", ofType: "md")
        // print(path)
        do {
            mdStr = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        }catch _ {}
        
        if mdStr != "" {
            mdStr = mdStr.stringByReplacingOccurrencesOfString("\n", withString: "\\n")
            mdStr = mdStr.stringByReplacingOccurrencesOfString("\'", withString: "\\'")
            mdStr = mdStr.stringByReplacingOccurrencesOfString("\"", withString: "\\\"")
        }

        parserMarkdownStrToHtml(mdStr) {
            (htmlStr) -> Void in
            self.loadModelHtml(htmlStr)
        }
        
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
    
    
    func loadModelHtml(html: String) {
        var htmlModel: String = ""
        let path = NSBundle.mainBundle().pathForResource("preview", ofType: "html")
        do {
            htmlModel = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        }catch _ {}
        
        var css: String = ""
        let cssPath = NSBundle.mainBundle().pathForResource("dark.min", ofType: "css")
        do {
            css = try String(contentsOfFile: cssPath!, encoding: NSUTF8StringEncoding)
        }catch _ {}
        
        
        let htmlStr = render(htmlModel, dict: [
                                            "content": html,
                                            "highlightCss": css
                                        ])

        self.webView.loadHTMLString(htmlStr, baseURL: NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath))
    }
    
    func render (var str: String, dict: Dictionary<String, String>) -> String {
        for (key, value) in dict {
            str = str.stringByReplacingOccurrencesOfString("{{\(key)}}", withString: value)
        }
        return str
    }
    
    func parserMarkdownStrToHtml(markedStr: String, callback: (htmlStr: String) -> Void) {
        
        let markedScriptURL = NSBundle.mainBundle().pathForResource("marked.min", ofType: "js")
        var markedJS: String = ""
        do {
            markedJS = try String(contentsOfFile:markedScriptURL!, encoding:NSUTF8StringEncoding)
        } catch _ {
            markedJS = ""
        }
        let evaluateJS = "\(markedJS);marked('\(markedStr)')"
        wkWebView.evaluateJavaScript(evaluateJS) {
            (result, error) -> Void in
            guard let resultStr = result else {
                callback(htmlStr: "")
                return
            }
            callback(htmlStr: resultStr as! String)
        }
    }
}
