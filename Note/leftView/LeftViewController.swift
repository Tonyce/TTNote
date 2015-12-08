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
    case Setting
}

class LeftViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    let tableData = [
        ["icon": GoogleIcon.e920, "name":"Note"],
        ["icon": GoogleIcon.e920, "name":"文件传输"],
        ["icon": GoogleIcon.e6c5, "name":"Setting"]
    ]
    var mainViewController: UIViewController!
    var webServerViewController: UIViewController?
    var settingViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        settingViewController = storyboard.instantiateViewControllerWithIdentifier("SettingViewController") as! SettingViewController
        webServerViewController = storyboard.instantiateViewControllerWithIdentifier("WebServerViewController") as! WebServerViewController
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
    }
    
    func changeViewController(menu: LeftMenu) {
        switch menu {
        case .Note:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .WebServer:
            self.slideMenuController()?.changeMainViewController(self.webServerViewController!, close: true)
        case .Setting:
            self.slideMenuController()?.changeMainViewController(self.settingViewController!, close: true)
        }
    }
}
