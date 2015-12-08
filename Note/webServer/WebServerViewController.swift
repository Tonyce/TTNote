//
//  WebServerViewController.swift
//  Note
//
//  Created by D_ttang on 15/12/9.
//  Copyright © 2015年 D_ttang. All rights reserved.
//


import UIKit
import GCDWebServer

class WebServerViewController: UIViewController {
    
    @IBOutlet weak var webLabel: UILabel!
    var webServer: GCDWebUploader?
    override func viewDidLoad() {
        super.viewDidLoad()
       

        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
        
        webServer = GCDWebUploader(uploadDirectory: documentsPath)
        webServer?.delegate = self
        
        if webServer?.startWithPort(8080, bonjourName: "GCD Web Server") == true {
            webLabel.text = "\(webServer!.serverURL)"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        webServer?.stop()
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


extension WebServerViewController: GCDWebUploaderDelegate {
    func webUploader(uploader: GCDWebUploader!, didMoveItemFromPath fromPath: String!, toPath: String!) {
        
    }
    
    func webUploader(uploader: GCDWebUploader!, didUploadFileAtPath path: String!) {
        
    }
    
    func webUploader(uploader: GCDWebUploader!, didCreateDirectoryAtPath path: String!) {
        
    }
    
    func webUploader(uploader: GCDWebUploader!, didDeleteItemAtPath path: String!) {
        
    }
}
