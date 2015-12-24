//
//  LeftViewController.swift
//  Note
//
//  Created by D_ttang on 15/12/8.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case Note = 0
    case WebServer
//    case help
//    case feedback
    case Setting
}

protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}

class LeftViewController: UIViewController, LeftMenuProtocol {

    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let tableData = [
        ["icon": GoogleIcon.e920, "name":"Note"],
        ["icon": GoogleIcon.ec2e, "name":"wifi文件传输"],
//        ["icon": GoogleIcon.e66a, "name":"帮助"],
//        ["icon": GoogleIcon.e6f5, "name":"反馈"],
        ["icon": GoogleIcon.e6c5, "name":"设置"]
    ]
    var mainViewController: UIViewController!
    var webServerViewController: WebServerViewController?
    var settingViewController: SettingViewController?
    var feedbackViewController: FeedbackViewController?
    var helpViewController: HelpViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        versionLabel.text = "version: \(UIApplication.appVersion())"
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        settingViewController = storyboard.instantiateViewControllerWithIdentifier("SettingViewController") as? SettingViewController
        settingViewController!.delegate = self
        webServerViewController = storyboard.instantiateViewControllerWithIdentifier("WebServerViewController") as? WebServerViewController
        webServerViewController!.delegate = self
        feedbackViewController = storyboard.instantiateViewControllerWithIdentifier("FeedbackViewController") as? FeedbackViewController
        feedbackViewController?.delegate = self
        helpViewController = storyboard.instantiateViewControllerWithIdentifier("HelpViewController") as? HelpViewController
        helpViewController?.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LeftViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("leftCell") as! LeftViewCell
        cell.cellInfo = tableData[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func changeViewController(menu: LeftMenu) {
        switch menu {
        case .Note:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)

        case .WebServer:
            self.slideMenuController()?.changeMainViewController(self.webServerViewController!, close: true)
//        case .help:
//            self.slideMenuController()?.changeMainViewController(self.helpViewController!, close: true)
//        case .feedback:
//            self.slideMenuController()?.changeMainViewController(self.feedbackViewController!, close: true)
        case .Setting:
            self.slideMenuController()?.changeMainViewController(self.settingViewController!, close: true)

        }
    }
}

extension LeftViewController {
    @IBAction func displayLogin(sender: AnyObject) {
        displayAlert("")
    }
    func displayAlert(message: String){
        let alertController = UIAlertController(title: "退出？", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default,handler: {
            _ in
        }))
        // self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
