//
//  ViewController.swift
//  GitHub-Commits
//
//  Created by Erick Sanchez on 2/26/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    private var viewModel = ViewControllerModel()
    
    // MARK: - RETURN VALUES
    
    class func loadFromNib() -> ViewController {
        let storyboard = NSStoryboard(name: .init(rawValue: "Main"), bundle: Bundle.main)
        
        return storyboard.instantiateController(withIdentifier: .init(rawValue: "ViewController")) as! ViewController
    }
    
    // MARK: - VOID METHODS
    
    private func updateUI() {
        
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if viewModel.isLoggedIn() {
            viewModel.collectProfileStats { [weak self] in
                self?.updateUI()
            }
        } else {
            PersistanceStack.username = "LinnierGames"
            self.viewWillAppear()
        }
    }
}

