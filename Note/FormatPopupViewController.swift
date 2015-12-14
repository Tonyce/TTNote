//
//  FormatPopupViewController.swift
//  Note
//
//  Created by D_ttang on 15/12/14.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

protocol SelectFormatDelegate: class {
    func selectFormat(name: String)
}

class FormatPopupViewController: PopupViewController {

    var delegate: SelectFormatDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func txtFormatAction(sender: AnyObject) {
        delegate?.selectFormat(".txt")
        dismissViewControllerAnimated(true) {
            _ in
        }
    }
    
    @IBAction func mdFormatAction(sender: AnyObject) {
        delegate?.selectFormat(".md")
        dismissViewControllerAnimated(true) {
            _ in
        }
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
