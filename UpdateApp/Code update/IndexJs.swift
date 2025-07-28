//
//  IndexJs.swift
//  UpdateApp
//
//  Created by Main on 28.07.2025.
//

import SwiftUI

struct IndexJs: View {
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
            Button("index.js"){
                start()
            }
            .alert("Ошибка изменения файла", isPresented: $showAlert) {
                Button("Закрыть", role: .cancel) {}
            }
        }
    }
    
    func start(){
        let filePath = "/Users/\(NSUserName())/\(appName)/index.js"
        
        if fileManager.fileExists(atPath: filePath) {
            
            let fileURL = URL(fileURLWithPath: filePath)
            let replacedString = """
// Скопировать код index.js

import {AppRegistry} from 'react-native';
import messaging from '@react-native-firebase/messaging';
import App from './App';
import {name as appName} from './app.json';

messaging().setBackgroundMessageHandler(async remoteMessage => {
  console.log('Message handled in the background!', remoteMessage);
});

AppRegistry.registerComponent(appName, () => App);
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
