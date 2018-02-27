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
    
    lazy var dismissEvent: EventMonitor = {
        var event = EventMonitor(mask: [.leftMouseUp, .rightMouseUp]) { [weak self] (event) in
            self?.closePopover()
        }
        
        return event
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
            closePopover()
        } else {
            showPopover()
        }
    }
    
    func showPopover() {
        guard let button = statusItem.button else { return }
        
        popover.show(
            relativeTo: button.bounds,
            of: button,
            preferredEdge: .minY
        )
        dismissEvent.beginMonitoring()
    }
    
    func closePopover() {
        popover.performClose(nil)
        dismissEvent.terminateMonitoring()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

