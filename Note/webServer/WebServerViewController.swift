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
    
    @IBOutlet weak var webServerLabel: UILabel!
    @IBOutlet weak var webLabel: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    weak var delegate: LeftMenuProtocol?
    
    var webServer: GCDWebUploader?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        closeBtn.backgroundColor = UIColor.clearColor()
        closeBtn.titleLabel?.font = UIFont(name: "googleicon", size: 21)
        closeBtn.setTitle(GoogleIcon.ebd0, forState: UIControlState.Normal)
        
        menuBtn.backgroundColor = UIColor.clearColor()
        menuBtn.titleLabel?.font = UIFont(name: "googleicon", size: 22)
        menuBtn.setTitle(GoogleIcon.ea6d, forState: UIControlState.Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
        
        if webServer == nil {
            webServer = GCDWebUploader(uploadDirectory: documentsPath)
        }
        webServer?.delegate = self
        
        guard let server = webServer else {
            webLabel.text = "请确保您已经接入wifi局域网"
            return
        }
        
        if server.startWithPort(8080, bonjourName: "GCD Web Server") == true {
            if server.serverURL != nil {
                webServerLabel.text = "请在浏览器中输入以下地址："
                webLabel.text = "\(webServer!.serverURL)"
            } else {
                webLabel.text = "请确保您已经接入wifi局域网"
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        webServer?.stop()
        webServer = nil
    }


    @IBAction func menu(sender: AnyObject) {
        self.slideMenuController()?.toggleLeft()
    }
    
    @IBAction func close(sender: AnyObject) {
        delegate?.changeViewController(LeftMenu.Note)
    }
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
