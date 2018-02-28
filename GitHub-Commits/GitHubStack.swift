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
    
    private var session = URLSession.shared
    
    /**
     Calls and fetches all information such as the number of commits
     */
    func updateStats(completion: @escaping (Profile) -> ()) {
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
                
                if let profileStatus = NSString.pharseHtml(from: htmlString as String, searchingFor: stringDate) { //If a commit was made for today
                    let profile = Profile(username: username, numberOfCommits: profileStatus.nCommits, currentCommmitColor: profileStatus.color)
                    
                    DispatchQueue.main.async {
                        completion(profile)
                    }
                } else {
                    let profile = Profile(username: username, numberOfCommits: 0, currentCommmitColor: NSColor(deviceWhite: 1.0, alpha: 1.0))
                    
                    DispatchQueue.main.async {
                        completion(profile)
                    }
                }
            }).resume()
        }
    }
}

extension NSString {
    static func pharseHtml(from htmlString: String, searchingFor dateString: NSString) -> (color: NSColor, nCommits: Int)? {
        var stats: (NSColor, Int)? = nil
        
        htmlString.enumerateLines { (aString, unsafePointer) in
            if aString.contains("data-date=\"\(dateString)\"" as String) {
                
                let commits: Int
                /** Commits */
                do {
                    let regex = try! NSRegularExpression(pattern: "data-count=\"(\\d+)\"" as String)
                    let results = regex.matches(in: aString,
                                                range: NSRange(aString.startIndex..., in: aString))
                    if let nCommits = results.map({ (result) -> Int in
                        Int(aString[Range(result.range(at: 1), in: aString)!])!
                    }).first { //a number of commits was found
                        commits = nCommits
                    } else { //default number
                        commits = 0
                    }
                }
                
                let color: String
                /** Color */
                do {
                    let regex = try! NSRegularExpression(pattern: "fill=\"#(.{6})\"" as String)
                    let results = regex.matches(in: aString,
                                                range: NSRange(aString.startIndex..., in: aString))
                    if let aColor = results.map({ (result) -> String in
                        String(aString[Range(result.range(at: 1), in: aString)!])
                    }).first { //a color was found
                        color = aColor
                    } else { //default color
                        color = "ffffff"
                    }
                }
                let colour = NSColor(hex: color)
                
                stats = (colour, commits)
            }
        }
        
        return stats
    }
    
    static func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}

extension NSColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }

}
