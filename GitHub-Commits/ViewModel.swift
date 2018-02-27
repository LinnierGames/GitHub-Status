//
//  ViewModel.swift
//  GitHub-Commits
//
//  Created by Erick Sanchez on 2/26/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

struct ViewControllerModel {
    
    private var github = GitHubStack()
    
    var username: String? {
        return PersistanceStack.username
    }
    
    func isLoggedIn() -> Bool {
        return username != nil
    }
    
    mutating func collectProfileStats(completionHandler: @escaping (Profile) -> ()) {
        github.updateStats(completion: completionHandler)
    }
}
