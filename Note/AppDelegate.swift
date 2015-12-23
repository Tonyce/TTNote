//
//  AppDelegate.swift
//  Note
//
//  Created by D_ttang on 15/12/7.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
//import SlideMenuControllerSwift

@available(iOS 9.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK: Static Properties
    static let applicationShortcutUserInfoIconKey = "applicationShortcutUserInfoIconKey"

    /// Saved shortcut item used as a result of an app launch, used later when app is activated.
    var launchedShortcutItem: UIApplicationShortcutItem?
    // MARK: Types
    enum ShortcutIdentifier: String {
        case First
        case Second
        case Third
        case Fourth
        
        // MARK: Initializers
        
        init?(fullType: String) {
            guard let last = fullType.componentsSeparatedByString(".").last else {
                return nil
            }
            
            self.init(rawValue: last)
        }
        
        // MARK: Properties
        
        var type: String {
            return NSBundle.mainBundle().bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    
    @available(iOS 9.0, *)
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        // Verify that the provided `shortcutItem`'s `type` is one handled by the application.
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else { return false }
        
        guard let shortCutType = shortcutItem.type as String? else { return false }
        
        switch (shortCutType) {
        case ShortcutIdentifier.First.type:
            // Handle shortcut 1 (static).
            handled = true
            break
        case ShortcutIdentifier.Second.type:
            // Handle shortcut 2 (static).
            handled = true
            break
        case ShortcutIdentifier.Third.type:
            // Handle shortcut 3 (dynamic).
            handled = true
            break
        case ShortcutIdentifier.Fourth.type:
            // Handle shortcut 4 (dynamic).
            handled = true
            break
        default:
            break
        }
        
//        // Construct an alert using the details of the shortcut used to open the application.
//        let alertController = UIAlertController(title: "Shortcut Handled", message: "\"\(shortcutItem.localizedTitle)\"", preferredStyle: .Alert)
//        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//        alertController.addAction(okAction)
//        
////         Display an alert indicating the shortcut selected from the home screen.
        let slideMenuController = window!.rootViewController as! SlideMenuController
        let nvc = slideMenuController.mainViewController as! UINavigationController
        let viewController = nvc.viewControllers.first as! ViewController
        viewController.presentAlert("文件名", isFile: true)
        viewController.adding(0.2)

        return handled
    }
    
    // MARK: Application Life Cycle

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
//        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! ViewController
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("LeftViewController") as! LeftViewController
        
        let nvc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("MainNav") as! UINavigationController
        
//        UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
//        return true
        
        // Override point for customization after application launch.
        var shouldPerformAdditionalDelegateHandling = true
        
        // If a shortcut was launched, display its information and take the appropriate action
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            launchedShortcutItem = shortcutItem
            
            // This will block "performActionForShortcutItem:completionHandler" from being called.
            shouldPerformAdditionalDelegateHandling = false
        }
        return shouldPerformAdditionalDelegateHandling
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        guard let shortcut = launchedShortcutItem else {
            return
        }
        
        handleShortCutItem(shortcut)
        launchedShortcutItem = nil
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /*
    Called when the user activates your application by selecting a shortcut on the home screen, except when
    application(_:,willFinishLaunchingWithOptions:) or application(_:didFinishLaunchingWithOptions) returns `false`.
    You should handle the shortcut in those callbacks and return `false` if possible. In that case, this
    callback is used if your application is already launched in the background.
    */
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: Bool -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        
        completionHandler(handledShortCutItem)
    }
}

