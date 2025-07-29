//
//  Section02VSCode.swift
//  MainCRM
//
//  Created by Main on 24.03.2025.
//

import SwiftUI

struct Section02VSCode: View {
    var app: TaskWebViewModel
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
            
            DefaultButtonView(title: "Готово") {
                sections.append(index+1)
            }
        }
        .sectionModifiers()
    }
}
