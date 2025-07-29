//
//  StringXML.swift
//  UpdateApp
//
//  Created by Main on 29.07.2025.
//

import SwiftUI

struct StringXML: View {
    var app: TaskWebViewModel
    var fileManager: FileManager = .default
    @State private var showAlert: Bool = false
    @State private var success: Bool = false
    
    var body: some View {
        if success {
            Image(systemName: "checkmark.circle")
                .foregroundStyle(.green)
                .padding()
        }else {
            Button("strings.xml"){
                start()
            }
            .alert("Ошибка изменения файла", isPresented: $showAlert) {
                Button("Закрыть", role: .cancel) {}
            }
        }
    }
    
    func start(){
        let filePath = "/Users/\(NSUserName())/\(app.firstAppName)/android/app/src/main/res/values/strings.xml"
        
        if fileManager.fileExists(atPath: filePath) {
            
            let fileURL = URL(fileURLWithPath: filePath)
            let replacedString = """
<resources>
    <string name="app_name">\(app.newAppName)</string>
</resources>
"""
            do {
                try replacedString.write(to: fileURL, atomically: true, encoding: .utf8)
                success = true
            } catch {
                showAlert = true
            }
        } else {
            showAlert = true
        }
    }
}
