//
//  GitHubStack.swift
//  GitHub-Commits
//
//  Created by Erick Sanchez on 2/26/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation
import Cocoa

struct GitHubStack {
    
    private let baseUrl = "https://github.com/"
    
    typealias Response = (Profile) -> ()
    
    var completionHandler: Response
    private var session = URLSession.shared
    
    init(completion: @escaping Response) {
        self.completionHandler = completion
    }
    
    /**
     Calls and fetches all information such as the number of commits
     */
    func updateStats() {
        guard let username = PersistanceStack.username else {
            return assertionFailure("username was not set")
        }
        
        if let url = URL(string: baseUrl.appending(username)) {
            session.downloadTask(with: url, completionHandler: { (url, response, error) in
                guard error == nil else { print(error!.localizedDescription); return }
                
                guard
                    let htmlUrl = url,
                    let htmlString = try? NSString(contentsOf: htmlUrl, encoding: String.Encoding.utf8.rawValue) else {
                        return print("did not work")
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let stringDate = dateFormatter.string(from: Date()) as NSString
                
                guard let profileStatus = NSString.pharseHtml(from: htmlString, searchingFor: stringDate) else {
                    return print("failed to get status from html")
                }
                
                let profile = Profile(username: username, numberOfCommits: profileStatus.nCommits)
                
                self.completionHandler(profile)
            }).resume()
        }
    }
}

extension NSString {
    static func pharseHtml(from htmlString: NSString, searchingFor dateString: NSString) -> (color: NSColor, nCommits: Int)? {
        print(htmlString)
        
        return nil
    }
}
