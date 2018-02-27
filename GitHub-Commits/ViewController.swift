//
//  ViewController.swift
//  GitHub-Commits
//
//  Created by Erick Sanchez on 2/26/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // MARK: - RETURN VALUES
    
    class func loadFromNib() -> ViewController {
        let storyboard = NSStoryboard(name: .init(rawValue: "Main"), bundle: Bundle.main)
        
        return storyboard.instantiateController(withIdentifier: .init(rawValue: "ViewController")) as! ViewController
    }
    
    // MARK: - VOID METHODS
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE

}

