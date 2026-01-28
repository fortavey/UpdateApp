//
//  Helpers.swift
//  UpdateApp
//
//  Created by MiniA on 25.01.2026.
//

import Foundation
import SwiftUI

struct Helpers {
    let fileManager = FileManager.default
    let runFilePath = "/Users/\(NSUserName())/projects/run.sh"
    let runFileURL = URL(fileURLWithPath: "/Users/\(NSUserName())/projects/run.sh")
    
    func getSectionImageName(number: Int) -> String {
        if number < 10 {
            return "0\(number).square"
        }
        return "\(number).square"
    }
    
    func contentOfRunFile(content: String) {
        let replacedString = content
        do {
            try replacedString.write(to: runFileURL, atomically: true, encoding: .utf8)
        } catch {
            
        }
    }
    
    func openTerminal(content: String) {
        
        contentOfRunFile(content: content)
        
        let urlsToOpen = [URL(filePath: runFilePath)]
        let appURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: "com.apple.Terminal")!

        let configuration = NSWorkspace.OpenConfiguration()

        NSWorkspace.shared.open(urlsToOpen,
                                withApplicationAt: appURL,
                                configuration: configuration) { (app, error) in
            if let error = error {
                print("Failed to open URLs: \(error.localizedDescription)")
            } else if let runningApp = app {
                print("Successfully opened with: \(runningApp.localizedName ?? "Application")")
            }
        }
    }
    
    func isFileHasContent(filePath: String, searchString: String) -> Bool {
        
        if fileManager.fileExists(atPath: filePath) {
            
            do {
                let fileURL = URL(fileURLWithPath: filePath)
                let fileData = try Data(contentsOf: fileURL)
                if let fileContents = String(data: fileData, encoding: .utf8) {
                    if fileContents.contains(searchString) {
                        return true
                    }else {
                        return false
                    }
                }else {
                    return false
                }
            }catch {
                return false
            }
        }else {
            return false
        }
    }
}
