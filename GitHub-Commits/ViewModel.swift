//
//  ViewModel.swift
//  GitHub-Commits
//
//  Created by Erick Sanchez on 2/26/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

struct ViewControllerModel {
    
    private lazy var github: GitHubStack = {
        return GitHubStack(completion: self.didFetch)
    }()
    
    private func didFetch(_ profile: Profile) {
        
    }
    
    func isLoggedIn() -> Bool {
        return PersistanceStack.username != nil
    }
    
    mutating func collectProfileStats(completionHandler: @escaping () -> ()) {
        github.updateStats()
    }
}
