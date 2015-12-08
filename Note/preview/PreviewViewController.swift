//
//  MePreviewViewController.swift
//  NoSingle
//
//  Created by D_ttang on 15/11/18.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
import WebKit

//protocol PublishSuccessDelegate: class {
//    func publicSuccess()
//}

class PreviewViewController: UIViewController {

//    var publishSuccessDelegate: PublishSuccessDelegate?
//    var markdown = Markdown()
    var webView: WKWebView!
//    var uiWebView: UIWebView!
    
    @IBOutlet weak var uiWebView: UIWebView!
    var documentUrl: NSURL?
    var markdownStr: String = ""
    var htmlStr: String = ""
    var convertStr: String?
    
    let filemgr = NSFileManager.defaultManager()

    @IBOutlet weak var rightItemBtn: UIBarButtonItem!
    @IBOutlet weak var htmlBtn: UIButton!
    @IBOutlet weak var htmlTop: NSLayoutConstraint!
    @IBOutlet weak var ePubTop: NSLayoutConstraint!
    @IBOutlet weak var ePubBtn: UIButton!
    @IBOutlet weak var pdfTop: NSLayoutConstraint!
    @IBOutlet weak var pdfBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        initPreViewBtns()
        addWebViewToView()
        if markdownStr != "" {
            markdownStr = markdownStr.stringByReplacingOccurrencesOfString("\n", withString: "\\n")
            markdownStr = markdownStr.stringByReplacingOccurrencesOfString("\'", withString: "\\'")
            markdownStr = markdownStr.stringByReplacingOccurrencesOfString("\"", withString: "\\\"")
        }
        // print(markdownStr)
        parserMarkdownStrToHtml(markdownStr) {
            (htmlStr) -> Void in
            self.loadModelHtml(htmlStr)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - WKWebView init
    func addWebViewToView() {
        webView = WKWebView(frame: CGRectZero)
//        uiWebView = UIWebView(frame: CGRectZero)
        uiWebView.backgroundColor = UIColor.whiteColor()
//        view.insertSubview(uiWebView, atIndex: 0)
//        uiWebView.setConstraints(view, top: 0)
    }
    
    // MARK: - loadHtml
    func loadModelHtml(html: String) {
        var htmlModel: String = ""
        let path = NSBundle.mainBundle().pathForResource("preview", ofType: "html")
        do {
            htmlModel = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        }catch _ {}


        self.htmlStr = render(htmlModel, dict: [ "content": html ])
        uiWebView.loadHTMLString(self.htmlStr, baseURL: NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath))
        self.convertStr = uiWebView.stringByEvaluatingJavaScriptFromString("document.getElementsByClassName(\"content\")")
        // webView.loadHTMLString(htmlStr, baseURL: NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath))
    }
    
    func render (var str: String, dict: Dictionary<String, String>) -> String {
        for (key, value) in dict {
            str = str.stringByReplacingOccurrencesOfString("{{\(key)}}", withString: value)
        }
        return str
    }
    // MARK: parser markdown
    func parserMarkdownStrToHtml(markedStr: String, callback: (htmlStr: String) -> Void) {
        let markedScriptURL = NSBundle.mainBundle().pathForResource("marked.min", ofType: "js")
        var markedJS: String = ""
        do {
            markedJS = try String(contentsOfFile:markedScriptURL!, encoding:NSUTF8StringEncoding)
        } catch _ {
            markedJS = ""
        }
        let evaluateJS = "\(markedJS);marked('\(markedStr)')"
        webView.evaluateJavaScript(evaluateJS) {
            (result, error) -> Void in
            guard let resultStr = result else {
                callback(htmlStr: "")
                return
            }
            callback(htmlStr: resultStr as! String)
        }
    }
    
    /*
    @IBAction func publishArticle(sender: UIBarButtonItem) {
        Article.sharedInstance.postArticleToServer {
            result in
            if result == true {
                // print("success")
                // Article.sharedInstance.resetArticle()
                self.publishSuccessDelegate?.publicSuccess()
                // self.navigationController?.popViewControllerAnimated(true)
            }else {
                print("fail....")
            }
            
        }
    }
    */
}


extension PreviewViewController {
    
    func initPreViewBtns() {
        htmlBtn.alpha = 0
        htmlTop.constant = 0
        ePubBtn.alpha = 0
        ePubTop.constant = 0
        pdfBtn.alpha = 0
        pdfTop.constant = 0
        
        
        htmlBtn.setCircleRadius()
        htmlBtn.setShadow()
        ePubBtn.setCircleRadius()
        ePubBtn.setShadow()
        pdfBtn.setShadow()
        pdfBtn.setCircleRadius()
        
        self.view.layoutIfNeeded()
    }
    
    @IBAction func rigthItemAction(sender: AnyObject) {
        if htmlBtn.alpha == 1 {
            hidenPreViewBtns()
        }else {
            showPreViewBtns()
        }
    }
    
    func showPreViewBtns() {
        rightItemBtn.title = ""
        rightItemBtn.image = UIImage(named: "close")
        htmlTop.constant = 20
        ePubTop.constant = 20
        pdfTop.constant = 20
        UIView.animateWithDuration(0.3) { () -> Void in
            self.htmlBtn.alpha = 1
            self.ePubBtn.alpha = 1
            self.pdfBtn.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    func hidenPreViewBtns() {
        rightItemBtn.title = "保存"
        rightItemBtn.image = nil
        htmlTop.constant = 0
        ePubTop.constant = 0
        pdfTop.constant = 0
        UIView.animateWithDuration(0.3) { () -> Void in
            self.htmlBtn.alpha = 0
            self.ePubBtn.alpha = 0
            self.pdfBtn.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
}

extension PreviewViewController {
    
    @IBAction func saveToPDF(sender: AnyObject) {
        let html = self.uiWebView.stringByEvaluatingJavaScriptFromString("document.documentElement.innerHTML")!

        let fmt = UIMarkupTextPrintFormatter(markupText: html)
        
        // 2. Assign print formatter to UIPrintPageRenderer
        
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAtIndex: 0)
        
        // 3. Assign paperRect and printableRect
        
        let page = CGRect(x: 40, y: 30, width: 595.2, height: 841.8) // A4, 72 dpi
        let printable = CGRectInset(page, 0, 0)
        
        render.setValue(NSValue(CGRect: page), forKey: "paperRect")
        render.setValue(NSValue(CGRect: printable), forKey: "printableRect")
        
        // 4. Create PDF context and draw
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRectZero, nil)
        

        for i in 1...render.numberOfPages() {
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPageAtIndex(i - 1, inRect: bounds)
        }
        
        UIGraphicsEndPDFContext();
        
        // 5. Save PDF file
        
        guard let documentUrl = self.documentUrl else {
            return
        }
//        let NSFileName = filemgr.displayNameAtPath(documentUrl.path!)
//        let documentUrlParent = documentUrl.URLByDeletingLastPathComponent
//        let fileExtension = documentUrl.pathExtension
        let fileWithoutExtension = documentUrl.URLByDeletingPathExtension
        let pdfFile = fileWithoutExtension?.URLByAppendingPathExtension("pdf")

        pdfData.writeToURL(pdfFile!, atomically: true)
        print("save success...\(pdfFile)")
        hidenPreViewBtns()
    }
}
