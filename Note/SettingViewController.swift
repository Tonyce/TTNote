//
//  SettingViewController.swift
//  Note
//
//  Created by D_ttang on 15/12/8.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    weak var delegate: LeftMenuProtocol?
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var formatIcon: UILabel!
    @IBOutlet weak var nameIcon: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var formatBtn: UIButton!
    @IBOutlet weak var nameBtn: UIButton!
    
    let tableData = [
        ["icon": GoogleIcon.e96e, "name": "默认文件名：", "action": ".txt"],
        ["icon": GoogleIcon.e716, "name": "默认文件后缀：", "action": ".txt"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        closeBtn.backgroundColor = UIColor.clearColor()
        closeBtn.titleLabel?.font = UIFont(name: "googleicon", size: 21)
        closeBtn.setTitle(GoogleIcon.ebd0, forState: UIControlState.Normal)
        
        menuBtn.backgroundColor = UIColor.clearColor()
        menuBtn.titleLabel?.font = UIFont(name: "googleicon", size: 22)
        menuBtn.setTitle(GoogleIcon.ea6d, forState: UIControlState.Normal)
        
        formatIcon.font = UIFont(name: "googleicon", size: 16)
        formatIcon.text = GoogleIcon.e96e
        formatIcon.textColor = UIColor.MKColor.LightBlue
        
        nameIcon.font = UIFont(name: "googleicon", size: 16)
        nameIcon.text = GoogleIcon.e716
        nameIcon.textColor = UIColor.MKColor.LightBlue
        
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

extension SettingViewController: UIPopoverPresentationControllerDelegate {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let popupView = segue.destinationViewController
        if let popup = popupView.popoverPresentationController {
            popup.delegate = self
        }
        
        if let popup = popupView as? FormatPopupViewController {
            popup.delegate = self
        }
        
        if let popup = popupView as? NamePopupViewController {
            popup.delegate = self
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

}

extension SettingViewController: SelectFormatDelegate {
    func selectFormat(name: String) {
        formatBtn.setTitle(name, forState: UIControlState.Normal)
    }
}

extension SettingViewController: SelectNameDelegate {
    func selectName(name: String) {
        nameBtn.setTitle(name, forState: UIControlState.Normal)
    }
}