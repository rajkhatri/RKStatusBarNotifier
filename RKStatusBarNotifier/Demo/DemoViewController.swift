//
//  DemoViewController.swift
//  RKStatusBarNotifier
//
//  Created by Raj Khatri on 2016-01-16.
//  Copyright © 2016 Raj Khatri. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = .blackColor()
        title = "Look Above Me!"
        
        // Demo
        let testButton = UIButton(type: .System)
        testButton.frame = CGRectMake(CGRectGetMidX(view.frame)-150, CGRectGetMidY(view.frame), 300, 44)
        testButton.setTitle("Click for Notification", forState: .Normal)
        testButton.addTarget(self, action: "testBtnPressed", forControlEvents: .TouchUpInside)
        view.addSubview(testButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testBtnPressed() {
        // Just need to set these once [ Feel free to mess around with these parameters ]
//        Notifier.sharedInstance.shouldShowNewNotificationBeforePreviousOneHidden = true
//        Notifier.sharedInstance.statusBarNotifierLabel // <-- Can use to adjust font / text color etc.
//        Notifier.sharedInstance.statusBarAnimationDuration = 0.5
//        Notifier.sharedInstance.statusBarShowDurationLength = 3
        Notifier.sharedInstance.showStatusBarNotifier("Test RKStatusBarNotifier", andBackgroundColor: UIColor.greenColor())
    }
}

