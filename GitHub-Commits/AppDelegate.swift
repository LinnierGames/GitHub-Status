//
//  AppDelegate.swift
//  GitHub-Commits
//
//  Created by Erick Sanchez on 2/26/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let popover: NSPopover = {
        var pop = NSPopover()
        pop.contentViewController = ViewController.loadFromNib()
        
        return pop
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let button = statusItem.button {
            button.image = #imageLiteral(resourceName: "checkbox-none")
            button.action = #selector(showMenu(sender:))
        }
    }
    
    @objc func showMenu(sender: NSStatusBarButton) {
        if popover.isShown {
            popover.performClose(nil)
        } else {
            popover.show(
                relativeTo: sender.bounds,
                of: sender,
                preferredEdge: .minY
            )
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

