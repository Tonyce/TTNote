//
//  TextViewController.swift
//  Note
//
//  Created by D_ttang on 15/12/7.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    var keyboardRect = CGRectZero
    var document: MyDocument?
    var documentUrl: NSURL?
    var showTitle: String?
    let filemgr = NSFileManager.defaultManager()
    var editToolBarViewController: EditToolBarController!
    
    @IBOutlet weak var textViewBottom: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false

        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        textView.keyboardDismissMode = .Interactive
        
        self.title = showTitle

        editToolBarViewController = EditToolBarController()
        
        editToolBarViewController.view.frame.size.width = self.view.bounds.width
        editToolBarViewController.textView = self.textView
//        textView.inputAccessoryView = editToolBarViewController.view
        let tmpView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height:         editToolBarViewController.view.frame.size.height))

        tmpView.backgroundColor = UIColor.brownColor()
        tmpView.addSubview(editToolBarViewController.view)
        textView.inputAccessoryView = tmpView
        textView.textContainer.lineFragmentPadding = 15
        handleFile()
    }
    
    override func viewWillDisappear(animated: Bool) {
        saveText()
    }

    
    func handleFile() {
        document = MyDocument(fileURL: documentUrl!)
        let dataFile = documentUrl?.path
        guard let dataFilePath = dataFile else {
            return
        }
        if filemgr.fileExistsAtPath(dataFilePath) == true {
            document?.openWithCompletionHandler({
                (success: Bool) -> Void in
                if success == true {
                    self.textView.text = self.document?.userText
                }else {
                    print("fail to open file")
                }
            })
        }else {
            fatalError("should not go here")
            /*
            document?.saveToURL(documentUrl!, forSaveOperation: .ForCreating, completionHandler: {
                (success: Bool) -> Void in
                if success == true {
                    print("file created ok")
                }else {
                    print("failed to create file")
                }
            })
            */
        }
    }
    
    func saveText() {
        document?.userText = self.textView.text
        document?.saveToURL(documentUrl!, forSaveOperation: .ForOverwriting, completionHandler: {
            (success: Bool) -> Void in
            if success != true {
                print("fole overwrite failed")
            }
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "previewSegue" {
            let previewController = segue.destinationViewController as! PreviewViewController
            previewController.markdownStr = self.textView.text
            previewController.documentUrl = self.documentUrl
        }
    }
}

extension TextViewController {
    func handleKeyboardWillShow (notification: NSNotification){
        let keyboardRectAsObject = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        keyboardRectAsObject.getValue(&keyboardRect)
        textView.contentInset.bottom = keyboardRect.height
    }
    
    func handleKeyboardWillHide(notification: NSNotification){
        keyboardRect = CGRectZero
        textView.contentInset.bottom = keyboardRect.height
    }
}
