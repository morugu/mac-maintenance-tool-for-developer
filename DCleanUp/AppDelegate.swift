//
//  AppDelegate.swift
//  DCleanUp
//
//  Created by shoya on 2016/11/18.
//  Copyright © 2016 Shoya Shiraki. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        print(Command.execute(type: .Env))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

