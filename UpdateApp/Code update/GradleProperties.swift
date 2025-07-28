//
//  GradleProperties.swift
//  UpdateApp
//
//  Created by Main on 28.07.2025.
//

import SwiftUI

struct GradleProperties: View {
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
            Button("gradle.properties"){
                start()
            }
            .alert("Ошибка изменения файла", isPresented: $showAlert) {
                Button("Закрыть", role: .cancel) {}
            }
        }
    }
    
    func start(){
        let filePath = "/Users/\(NSUserName())/\(appName)/android/gradle.properties"
        
        if fileManager.fileExists(atPath: filePath) {
            
            do {
                let fileURL = URL(fileURLWithPath: filePath)
                let fileData = try Data(contentsOf: fileURL)
                if let fileContents = String(data: fileData, encoding: .utf8) {
                    let stringToReplace = "android.useAndroidX=true"
                    let replacementString = """
android.useAndroidX=true
android.enableJetifier=true
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
