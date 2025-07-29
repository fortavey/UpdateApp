//
//  BuildGradleApp.swift
//  UpdateApp
//
//  Created by Main on 28.07.2025.
//

import SwiftUI

struct BuildGradleApp: View {
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
            Button("build.gradle"){
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
                    if fileContents.contains("apply plugin: 'com.google.gms.google-services'") {
                        success = true
                        return
                    }
                    let stringToReplace = "apply plugin: \"com.facebook.react\""
                    let replacementString = """
apply plugin: "com.facebook.react"
apply plugin: 'com.google.gms.google-services'
"""
                    let replacedString = fileContents.replacingOccurrences(of: stringToReplace, with: replacementString)
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
}
