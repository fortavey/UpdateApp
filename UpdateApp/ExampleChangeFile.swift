//
//  ExampleChangeFile.swift
//  UpdateApp
//
//  Created by Main on 28.07.2025.
//

import SwiftUI

struct ExampleChangeFile: View {
    var fileManager: FileManager = .default
    var fileName = "/Users/\(NSUserName())/FreedomSweetHaven/android/gradle.properties"
    @State private var successText = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(successText)
            Button("Start"){
                start()
            }
        }
        .padding()
    }
    
    func start(){
        do {
            let fileURL = URL(fileURLWithPath: fileName)
            let fileData = try Data(contentsOf: fileURL)
            if let fileContents = String(data: fileData, encoding: .utf8) {
                    print(fileContents)
                let stringToReplace = "android.useAndroidX=true"
                let replacementString = """
android.useAndroidX=true
android.jetifier=false
"""
                let replacedString = fileContents.replacingOccurrences(of: stringToReplace, with: replacementString)
                do {
                    try replacedString.write(to: fileURL, atomically: true, encoding: .utf8)
                } catch {
                    print("Error writing to file: \(error.localizedDescription)")
                }
                
                }
            successText = "Выполнено"
        }catch {
            
        }
        
    }
}
