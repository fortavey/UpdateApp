//
//  Section02VSCode.swift
//  MainCRM
//
//  Created by Main on 24.03.2025.
//

import SwiftUI

struct Section02VSCode: View {
    var app: TaskWebViewModel
    @State private var isFilesExistError = false
    @State private var isKeyExistError = false
    @State private var isComplete: Bool = false
    @Binding var sections: [Int]
    var index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                Image(systemName: "02.square")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            Text("Редактирование кода в Android Studio")
                .font(.title)
            HStack{
                Text("Устанавливаем зависимости")
                CopyTextView(text: "npm i @react-navigation/elements @react-navigation/native @react-navigation/native-stack react-native-safe-area-context react-native-screens @react-native-firebase/app @react-native-firebase/analytics @react-native-firebase/firestore @react-native-firebase/messaging react-native-webview @react-native-async-storage/async-storage react-native-play-install-referrer")
            }
            
            Text("Настройки навигации")
                .font(.title)
                .padding(.bottom, 20)
            
            MainActivity(appName: app.firstAppName, isComplete: $isComplete)
            
            Divider()
            Text("gradle.properties")
                .font(.title)
            GradleProperties(appName: app.firstAppName)
            .padding(.bottom, 20)
            
            
            Divider()
            Text("build.gradle (Project:...)")
                .font(.title)
            
            BuildGradleProject(appName: app.firstAppName)
            
            
            Divider()
            Text("build.gradle (Module: app)")
                .font(.title)
            
            BuildGradleApp(appName: app.firstAppName)
            
            Divider()
            Text("Version code")
                .font(.title)
            
            VersionCode(appName: app.firstAppName)
            .padding(.bottom, 10)
            
            
            Divider()
            Text("index.js")
                .font(.title)
            
            IndexJs(appName: app.firstAppName)
            .padding(.bottom, 10)
    
            
            Divider()
            Text("App.tsx")
                .font(.title)
            
            AppTSX(appName: app.firstAppName)
            .padding(.bottom, 10)
            
            Divider()
            Text("string.xml")
                .font(.title)
            
            StringXML(app: app)
            .padding(.bottom, 10)
            
            
            Divider()
            Text("Синхронизируем зависимости в Android Studio")
                .font(.title)
                .padding(.bottom, 10)
            
            Text("Копируем файлы в проект")
                .font(.title)
            
            Text("Скачайте файлы проекта в папку Documents и распакуйте их")
                .font(.headline)
            
            if let link = URL(string: app.devLink) {
                Link(destination: link) {
                    HStack{
                        Text("Скачать")
                            .padding(.bottom, 10)
                        Image("GoogleDriveIcon")
                            .resizable()
                            .frame(width: 17, height: 17)
                    }
                }
            }
            
            Button("Переместить файлы"){
                isComplete = true
                let fileManager = FileManager.default
                let filePath = "/Users/\(NSUserName())/Documents/\(app.firstAppName)/App.tsx"

                if fileManager.fileExists(atPath: filePath) {
                    do {
                        try fileManager.removeItem(atPath: "/Users/\(NSUserName())/\(app.firstAppName)/App.tsx")
                        try fileManager.moveItem(atPath: "/Users/\(NSUserName())/Documents/\(app.firstAppName)/src", toPath: "/Users/\(NSUserName())/\(app.firstAppName)/src")
                        try fileManager.moveItem(atPath: "/Users/\(NSUserName())/Documents/\(app.firstAppName)/App.tsx", toPath: "/Users/\(NSUserName())/\(app.firstAppName)/App.tsx")
                        try fileManager.moveItem(atPath: "/Users/\(NSUserName())/Documents/\(app.firstAppName)/App1.tsx", toPath: "/Users/\(NSUserName())/\(app.firstAppName)/App1.tsx")
                    }catch {
                        print("Error moving icon: \(error)")
                    }
                }else {
                    isFilesExistError = true
                }
            }
            .alert("Файл проекта отсутствуют либо не распакованы", isPresented: $isFilesExistError) {
                Button("Закрыть", role: .cancel) {}
            }
            
            Button("Переместить файл ключа"){
                isComplete = true
                let fileManager = FileManager.default
                let filePath = "/Users/\(NSUserName())/Documents/\(app.firstAppName.lowercased()).keystore"

                if fileManager.fileExists(atPath: filePath) {
                    do {
                        try FileManager.default.moveItem(atPath: "/Users/\(NSUserName())/Documents/\(app.firstAppName.lowercased()).keystore", toPath: "/Users/\(NSUserName())/\(app.firstAppName)/android/app/\(app.firstAppName.lowercased()).keystore")
                    }catch {
                        print("Error moving icon: \(error)")
                    }
                }else {
                    isKeyExistError = true
                }
            }
            .alert("Файл ключей не существует", isPresented: $isKeyExistError) {
                Button("Закрыть", role: .cancel) {}
            }
                            
            if isComplete{
                DefaultButtonView(title: "Готово") {
                    sections.append(index+1)
                }
            }
        }
        .sectionModifiers()
    }
}
