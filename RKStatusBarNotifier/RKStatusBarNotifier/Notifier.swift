//
//  Notifier.swift
//  RKStatusBarNotifier
//
//  Created by Raj Khatri on 2016-01-16.
//  Copyright © 2016 Raj Khatri. All rights reserved.
//

import UIKit

class Notifier : NSObject {
    
    static let sharedInstance = Notifier()
    
    // Public setters
    
    // Set the duration of show for the notification
    var statusBarShowDurationLength:Int64 = 2
    
    // Set the animation in/out duration
    var statusBarAnimationDuration:NSTimeInterval = 0.3
    
    // Do not change frame; Access given to change font, styling.
    var statusBarNotifierLabel:UILabel!
    
    // If you want the notification to reset and show once a new one has shown BEFORE hiding the previous one
    var shouldShowNewNotificationBeforePreviousOneHidden = false
    
    // Private Vars
    private var statusBarNotifierView:UIView!
    private var statusBarWindow:UIWindow!
    private var isShowingNotification:Bool = false
    private var isAnimating = false
    
    override init() {
        super.init()
        
        // Initialize StatusBarNotifierView
        let statusBarHeight = CGRectGetHeight(UIApplication.sharedApplication().statusBarFrame)
        statusBarNotifierView = UIView(frame: CGRectMake(0, -statusBarHeight, CGRectGetWidth(UIScreen.mainScreen().bounds), statusBarHeight))
        
        statusBarWindow = UIWindow(frame: CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen().bounds), statusBarHeight))
        statusBarWindow.backgroundColor = UIColor.clearColor()
        statusBarWindow.windowLevel = UIWindowLevelStatusBar
        statusBarWindow.hidden = false
        
        statusBarNotifierLabel = UILabel(frame: CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen().bounds), statusBarHeight))
        statusBarNotifierLabel.textAlignment = .Center
        statusBarNotifierLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightMedium)
        
        statusBarNotifierView.addSubview(statusBarNotifierLabel)
    }
    
    func showStatusBarNotifier(notification:String?, andBackgroundColor backgroundColor:UIColor?) {
        
        if isAnimating { return }
        
        if shouldShowNewNotificationBeforePreviousOneHidden && isShowingNotification {
            statusBarWindow.layer.removeAllAnimations()
            statusBarNotifierView.layer.removeAllAnimations()
            isShowingNotification = false
        }
        
        if !isShowingNotification {
            statusBarNotifierView.frame.origin.y = -20
            statusBarNotifierView.backgroundColor = backgroundColor
            
            statusBarNotifierLabel.text = notification
            
            isShowingNotification = true
            
            // Add to window
            statusBarWindow.addSubview(statusBarNotifierView)
            
            isAnimating = true
            // Animate Notification IN
            UIView.animateWithDuration(statusBarAnimationDuration, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                
                self.statusBarNotifierView.frame.origin.y = 0
                
                }, completion: { (success) -> Void in
                    
                    self.isAnimating = false
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, self.statusBarShowDurationLength * Int64(NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
                        
                        // Animate OUT
                        
                        // Timer to remove from view if a new notification hasn't come in.
                        if self.isShowingNotification {
                            self.isAnimating = true
                            UIView.animateWithDuration(self.statusBarAnimationDuration, animations: { () -> Void in

                                self.statusBarNotifierView.frame.origin.y = -self.statusBarNotifierView.frame.size.height
                                }, completion: { (success) -> Void in
                                    
                                    // Remove from View, and remove text for next time
                                    self.statusBarNotifierView.removeFromSuperview()
                                    self.statusBarNotifierLabel.text = ""
                                    self.isShowingNotification = false
                                    self.isAnimating = false
                            })
                        }
                    })
                    
            })
        }
    }
    
}