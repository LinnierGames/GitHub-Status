//
//  EventStack.swift
//  GitHub-Commits
//
//  Created by Erick Sanchez on 2/26/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Cocoa

class EventMonitor {
    
    private var monitor: Any?
    private var mask: NSEvent.EventTypeMask
    private var handler: (NSEvent?) -> ()
    
    init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> ()) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        terminateMonitoring()
    }
    
    func beginMonitoring() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: self.handler)
    }
    
    func terminateMonitoring() {
        if let monitor = monitor {
            NSEvent.removeMonitor(monitor)
            self.monitor = nil
        }
    }
}
