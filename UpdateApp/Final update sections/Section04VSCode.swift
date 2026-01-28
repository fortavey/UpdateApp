//
//  Section02VSCode.swift
//  MainCRM
//
//  Created by Main on 24.03.2025.
//

import SwiftUI

struct Section04VSCode: View {
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
                Image(systemName: "04.square")
                    .resizable()
                    .frame(width: 20, height: 20)
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
                            
            DefaultButtonView(title: "Готово") {
                sections.append(index+1)
            }
        }
        .sectionModifiers()
    }
}
