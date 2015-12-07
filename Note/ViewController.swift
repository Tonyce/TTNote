//
//  ViewController.swift
//  Note
//
//  Created by D_ttang on 15/12/7.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dirBottom: NSLayoutConstraint!
    @IBOutlet weak var fileBottom: NSLayoutConstraint!
    @IBOutlet weak var addFileButton: UIButton!
    @IBOutlet weak var addDirButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let filemgr = NSFileManager.defaultManager()
    var documentUrl: NSURL?
    var isAdd: Bool?
    var showTitle: String?
    
    var tableData: [[String: AnyObject]] = []
    var indexPathForSelectedRow: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initButton()
        tableView.tableFooterView = UIView()
        tableData = []
        
        if documentUrl == nil {
            let documentsUrls = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            documentUrl = documentsUrls.first
        }
        getItems()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {

        if self.showTitle != nil {
            self.removeNavigationBarItem()
        }else {
            self.setNavigationBarItem()
        }
        
        if showTitle != nil {
            self.title = showTitle!
        }
        
        if indexPathForSelectedRow != nil {
            tableView.deselectRowAtIndexPath(indexPathForSelectedRow!, animated: true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = tableView.cellForRowAtIndexPath(indexPathForSelectedRow!) as? ItemCell
        let textViewController = segue.destinationViewController as! TextViewController
        textViewController.documentUrl = cell?.documentUrl
        textViewController.showTitle = cell?.title
    }

}

// MARK: - Item Attributes in documentUrl
extension ViewController {
    func getItems() {
        guard let documentsUrl = self.documentUrl else {
            return
        }
        do {
            
            let directoryContents = try filemgr.contentsOfDirectoryAtURL(documentsUrl, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions())
            self.getItemCatefory(directoryContents)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    func getItemCatefory(directoryContents: [NSURL]) {
        var tmpDirDatas: [[String: AnyObject]] = []
        var tmpFileDatas: [[String: AnyObject]] = []
        for i in 0..<directoryContents.count {
            let itemUrl = directoryContents[i]
            let itemPath = itemUrl.path
            
            do {
                var attributes = try filemgr.attributesOfItemAtPath(itemPath!)
                attributes["NSFileName"] = filemgr.displayNameAtPath(itemPath!)
                attributes["documentUrl"] = itemUrl
//                temData.append(attributes)
                let itemType = attributes["NSFileType"] as? String
                if itemType == "NSFileTypeRegular" {
                    tmpFileDatas.append(attributes)
                }else {
                    tmpDirDatas.append(attributes)
                }
            }catch _ {
                print("err in category")
            }
        }
        self.tableData = tmpDirDatas + tmpFileDatas
        self.tableView.reloadData()
    }
}


// MARK: - BUTTON SETUP AND ACTIONS
extension ViewController {
    
    func initButton() {
        addFileButton.alpha = 0.0
        addDirButton.alpha = 0.0
        
        addButton.setCircleRadius()
        addFileButton.setCircleRadius()
        addDirButton.setCircleRadius()
        dirBottom.constant = 0
        fileBottom.constant = 0
        
        addButton.setShadow()
        addFileButton.setShadow()
        addDirButton.setShadow()
        
        addButton.titleLabel?.font = UIFont(name: "googleicon", size: 30)
        addButton.setTitle(GoogleIcon.e803, forState: UIControlState.Normal)
        addButton.backgroundColor = UIColor.MKColor.LightBlue
        addButton.tintColor = UIColor.whiteColor()
        
        addDirButton.titleLabel?.font = UIFont(name: "googleicon", size: 30)
        addDirButton.setTitle(GoogleIcon.e9c3, forState: UIControlState.Normal)
        addDirButton.backgroundColor = UIColor.whiteColor()
        
        addFileButton.titleLabel?.font = UIFont(name: "googleicon", size: 30)
        addFileButton.setTitle(GoogleIcon.e985, forState: UIControlState.Normal)
        addFileButton.backgroundColor = UIColor.whiteColor()
    }
    
    @IBAction func addFileAction(sender: AnyObject) {
        presentAlert("文件名", isFile: true)
    }
    
    @IBAction func addDirAction(sender: AnyObject) {
        presentAlert("文件夹名", isFile: false)
    }
    
    func presentAlert(name: String, isFile: Bool?) {
        let alertController = UIAlertController(title: name, message:"", preferredStyle:UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
            textField.placeholder = name
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Default) { (alertAction) -> Void in
            print("You tapped cancel")

        }
        
        let ok = UIAlertAction(title: "OK", style: .Default) { (alertAction) -> Void in
            let name = alertController.textFields?.first?.text
            print("You tapped OK \(name!)")
            self.noAdding()
            if isFile == true {
                self.handleFile(name!)
            }else {
                self.handleDir(name!)
            }
        }
        
        alertController.addAction(cancel)
        
        alertController.addAction(ok)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addAction(sender: AnyObject) {
        let duration = 0.2
        if isAdd != false {
            adding(duration)
        }else {
            noAdding(duration)
        }
    }
    
    func adding(duration: Double) {
        isAdd = false
        dirBottom.constant = 20
        fileBottom.constant = 20
        let transformation = CGAffineTransformMakeRotation(CGFloat(-M_PI/4))
        self.addButton.backgroundColor = UIColor.redColor()
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.layoutIfNeeded()
            self.addButton.transform = transformation
            self.addDirButton.alpha = 1.0
            self.addFileButton.alpha = 1.0
        }
    }
    
    func noAdding(duration: Double = 0.2) {
        isAdd = true
        dirBottom.constant = 0
        fileBottom.constant = 0
        let transformation = CGAffineTransformMakeRotation(0)
        self.addButton.backgroundColor = UIColor.MKColor.LightBlue
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.layoutIfNeeded()
            self.addButton.transform = transformation
            self.addDirButton.alpha = 0.0
            self.addFileButton.alpha = 0.0
        }
    }
    
    func handleFile(fileName: String) {
        let newFileUrl = self.documentUrl?.URLByAppendingPathComponent("\(fileName).txt")
        let newFilePath = newFileUrl?.path
        
        guard let filePath = newFilePath else {
            return
        }
        let dataBuffer = filemgr.contentsAtPath(filePath)
        if filemgr.createFileAtPath(filePath, contents: dataBuffer, attributes: nil) == false {
            print("createFileAtPathFaile: \(filePath)")
            return
        }
        getItems()
    }
    
    func handleDir(newDirName: String) {
        let newDir = self.documentUrl?.URLByAppendingPathComponent(newDirName)
        guard let newDirUrl = newDir else {
            return
        }
        do {
            try filemgr.createDirectoryAtURL(newDirUrl, withIntermediateDirectories: true, attributes: nil)
        }catch _ {
            print("err: )")
            fatalError()
        }
        getItems()
    }
    
    func removeDocument(documentUrl: NSURL) -> Bool {
        var done = true
        do {
            try filemgr.removeItemAtURL(documentUrl)
        }catch _ {
            print("romove fail: \(documentUrl)")
            done = false
        }
        return done
    }
}

// MARK: - TABLEVIEW DELEGATE
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            let cell = tableView.cellForRowAtIndexPath(indexPath) as? ItemCell
            let documentUrl = cell?.documentUrl
            let removeSuccess = self.removeDocument(documentUrl!)
            if removeSuccess == true {
                tableData.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }else {
                
                print("fail...")
            }

        } else if editingStyle == .Insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ItemCell = tableView.dequeueReusableCellWithIdentifier("cell") as! ItemCell
        cell.itemInfo = tableData[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        indexPathForSelectedRow = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? ItemCell
        if cell?.isDir == true {
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("MainViewController") as! ViewController
            viewController.documentUrl = cell?.documentUrl
            viewController.showTitle = cell?.title
            self.navigationController?.pushViewController(viewController, animated: true)
        }else {
            self.performSegueWithIdentifier("textSegue", sender: self)
        }
    }
}




//let alertController = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
//
//let margin:CGFloat = 8.0
//let rect = CGRectMake(margin, margin, alertController.view.bounds.size.width - margin * 4.0, 100.0)
//let customView = UIView(frame: rect)
//
//customView.backgroundColor = UIColor.greenColor()
//alertController.view.addSubview(customView)
//
//let somethingAction = UIAlertAction(title: "Something", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("something")})
//
//let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
//
//alertController.addAction(somethingAction)
//alertController.addAction(cancelAction)
//
//self.presentViewController(alertController, animated: true, completion:{})
//
//["NSFileSystemFileNumber": 91669281, "NSFileExtensionHidden": 0, "NSFileModificationDate": 2015-12-07 11:41:14 +0000, "NSFileGroupOwnerAccountID": 20, "NSFileName": test, "NSFileOwnerAccountID": 502, "NSFileSize": 68, "NSFileCreationDate": 2015-12-07 11:41:14 +0000, "NSFileSystemNumber": 16777221, "documentUrl": file:///Users/d_ttang/Library/Developer/CoreSimulator/Devices/09A5D085-CA79-4995-8308-D825472F9F4E/data/Containers/Data/Application/F8928A05-A891-4425-9B5F-9C19504DCA69/Documents/test/, "NSFilePosixPermissions": 493, "NSFileReferenceCount": 2, "NSFileGroupOwnerAccountName": staff, "NSFileType": NSFileTypeDirectory]
//    ["NSFileSystemFileNumber": 91669279, "NSFileExtensionHidden": 0, "NSFileModificationDate": 2015-12-07 11:41:09 +0000, "NSFileGroupOwnerAccountID": 20, "NSFileName": test.txt, "NSFileOwnerAccountID": 502, "NSFileSize": 0, "NSFileCreationDate": 2015-12-07 11:41:09 +0000, "NSFileSystemNumber": 16777221, "documentUrl": file:///Users/d_ttang/Library/Developer/CoreSimulator/Devices/09A5D085-CA79-4995-8308-D825472F9F4E/data/Containers/Data/Application/F8928A05-A891-4425-9B5F-9C19504DCA69/Documents/test.txt, "NSFilePosixPermissions": 420, "NSFileReferenceCount": 1, "NSFileGroupOwnerAccountName": staff, "NSFileType": NSFileTypeRegular]

