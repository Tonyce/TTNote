//
//  PDFViewController.swift
//  Note
//
//  Created by D_ttang on 15/12/8.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
import M13PDFKit

class PDFViewController: PDFKBasicPDFViewer {
    
    var documentUrl: NSURL?
    var showTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.enableSharing = false
//        self.enablePrinting = false
//        self.standalone = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        self.title = showTitle
//        self.toolbarItems
//        PDFKDocument(contentsOfFile: <#T##String!#>, password: <#T##String!#>)
        let document: PDFKDocument = PDFKDocument(contentsOfFile: documentUrl?.path!, password: nil)

        self.loadDocument(document)
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
