//
//  PersistanceStack.swift
//  GitHub-Commits
//
//  Created by Erick Sanchez on 2/26/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

struct PersistanceStack {
    private static let USERNAME = "USERNAME"
    
    static var username: String? {
        get {
            let ud = UserDefaults.standard
            
            return ud.string(forKey: USERNAME)
        }
        set {
            let ud = UserDefaults.standard
            
            ud.set(newValue, forKey: USERNAME)
        }
    }
}
