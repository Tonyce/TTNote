//
//  TextViewController.swift
//  Note
//
//  Created by D_ttang on 15/12/7.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    var document: MyDocument?
    var documentUrl: NSURL?
    var showTitle: String?
    let filemgr = NSFileManager.defaultManager()
    
    @IBOutlet weak var textViewBottom: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false

        // Do any additional setup after loading the view.
        self.title = showTitle
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
//            document?.saveToURL(documentUrl!, forSaveOperation: .ForCreating, completionHandler: {
//                (success: Bool) -> Void in
//                if success == true {
//                    print("file created ok")
//                }else {
//                    print("failed to create file")
//                }
//            })
        }
    }
    
    func saveText() {
        document?.userText = self.textView.text
        document?.saveToURL(documentUrl!, forSaveOperation: .ForOverwriting, completionHandler: {
            (success: Bool) -> Void in
            if success == true {
//                print("file over write ok")
            }else {
                print("fole overwrite failed")
            }
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
