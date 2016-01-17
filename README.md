# RKStatusBarNotifier

An In-App Notification over the Status Bar

A Simple Class that will allow you to add a custom look and feel status bar notification
in the app. This notification can be shown in any view hierarchy. There are certain properties
that allow for access to change the way you use this.

## Installation

Coming Soon to Cocoapods

## Usage

In order to use this, you can just use the `Notifier` class' sharedInstance.

A simple call to `showStatusBarNotifier(notificationText, andBackgroundColor: backgroundColor)`
will allow you to show the notification in your app with the default parameters.

	// Example Call
	 Notifier.sharedInstance.showStatusBarNotifier("Test RKStatusBarNotifier", andBackgroundColor: UIColor.redColor())

Other properties that you can customize

	// Allows you to show a new notification, before the previous one has ended
	// Reset the previous one to show a new one.
	shouldShowNewNotificationBeforePreviousOneHidden

	// Access to the UILabel to change its properties
	statusBarNotifierLabel

	// Allows you to change the duration it takes to show/hide the notification
	statusBarAnimationDuration

	// Allows you to customize duration of the notification on the screen
	statusBarShowDurationLength
	
Note that the customization flags must be set before calling the `showStatusBarNotifier` function

The RKStatusBarNotifier creates a new UIWindow, that is shown above most of the other UI Layers.

You can download and see the Demo for usages.

## Notes
Requires iOS 8 or greater. Written in Swift 2.0
