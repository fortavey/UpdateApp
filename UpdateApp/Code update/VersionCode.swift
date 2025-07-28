//
//  VersionCode.swift
//  UpdateApp
//
//  Created by Main on 28.07.2025.
//

import SwiftUI

struct VersionCode: View {
    var appName: String
    var fileManager: FileManager = .default
    @State private var showAlert: Bool = false
    @State private var success: Bool = false
    
    var body: some View {
        if success {
            Image(systemName: "checkmark.circle")
                .foregroundStyle(.green)
                .padding()
        }else {
            Button("Version+"){
                start()
            }
            .alert("Ошибка изменения файла", isPresented: $showAlert) {
                Button("Закрыть", role: .cancel) {}
            }
        }
    }
    
    func start(){
        let filePath = "/Users/\(NSUserName())/\(appName)/android/app/build.gradle"
        
        if fileManager.fileExists(atPath: filePath) {
            
            do {
                let fileURL = URL(fileURLWithPath: filePath)
                let fileData = try Data(contentsOf: fileURL)
                if let fileContents = String(data: fileData, encoding: .utf8) {
                    var replacedString = replaceVersionCode(fileContents: fileContents)
                    replacedString = replaceVersionName(fileContents: replacedString)
                    do {
                        try replacedString.write(to: fileURL, atomically: true, encoding: .utf8)
                        success = true
                    } catch {
                        showAlert = true
                    }
                }
            }catch {
                showAlert = true
            }
        } else {
            showAlert = true
        }
    }
    
    func replaceVersionCode(fileContents: String) -> String {
        for n in 1...5 {
            if fileContents.contains("versionCode \(n)") {
                let stringToReplace = "versionCode \(n)"
                let replacementString = "versionCode \(n+1)"
                return fileContents.replacingOccurrences(of: stringToReplace, with: replacementString)
            }
        }
        
        return fileContents
    }
    func replaceVersionName(fileContents: String) -> String {
        for n in 0...5 {
            if fileContents.contains("versionName \"1.\(n)\"") {
                let stringToReplace = "versionName \"1.\(n)\""
                let replacementString = "versionName \"1.\(n+1)\""
                return fileContents.replacingOccurrences(of: stringToReplace, with: replacementString)
            }
        }
        
        return fileContents
    }
}
