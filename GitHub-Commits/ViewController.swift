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
    
    private var profile: Profile?
    
    // MARK: - RETURN VALUES
    
    class func loadFromNib() -> ViewController {
        let storyboard = NSStoryboard(name: .init(rawValue: "Main"), bundle: Bundle.main)
        
        return storyboard.instantiateController(withIdentifier: .init(rawValue: "ViewController")) as! ViewController
    }
    
    // MARK: - VOID METHODS
    
    @IBOutlet weak var labelUsername: NSTextField!
    @IBOutlet weak var labelCommits: NSTextField!
    
    private func updateUI() {
        guard let profile = profile else { return }
        
        self.labelUsername.stringValue = profile.username
        self.labelCommits.stringValue = String(profile.numberOfCommits ?? 0)
        self.view.layer!.backgroundColor = profile.currentCommmitColor.cgColor
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        self.view.wantsLayer = true
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if viewModel.isLoggedIn() {
            self.labelUsername.stringValue = viewModel.username!
            viewModel.collectProfileStats { [weak self] (profile) in
                self?.profile = profile
                self?.updateUI()
            }
        } else {
            self.labelUsername.stringValue = "Please enter a username"
            PersistanceStack.username = "LinnierGames"
            self.viewWillAppear()
        }
    }
}

