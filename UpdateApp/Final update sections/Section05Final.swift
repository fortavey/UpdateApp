//
//  Section05Final.swift
//  MainCRM
//
//  Created by Main on 24.03.2025.
//

import SwiftUI
import Cocoa

struct Section05Final: View {
    var app: TaskWebViewModel
    @Binding var sections: [Int]
    var index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                Image(systemName: "05.square")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            Text("Добавляем иконку, меняем название, заливаем билд")
                .font(.title)
            Text("Добавляем иконку")
                .font(.title3)
            
            if let link = URL(string: app.creoLink) {
                Link(destination: link) {
                    HStack{
                        Text("Открыть Google Диск")
                        Image("GoogleDriveIcon")
                            .resizable()
                            .frame(width: 17, height: 17)
                    }
                }
            }
            
            HStack{
                Text("Меняем название приложения: ")
                CopyTextView(text: app.newAppName)
            }
            
            
            HStack{
                Text("Собираем билд")
                    .font(.title2)
                CopyTextView(text: "npx react-native build-android --mode=release")
            }
            
            Button("Открыть папку с билдом"){
                openFinder(at: "/Users/\(NSUserName())/\(app.firstAppName)/android/app/build/outputs/bundle/release")
            }
            
            HStack {
                Text("Загружаем собранный билд для приложения ")
                CopyTextView(text: app.appId)
                Text(" на аккаунт - ")
                CopyTextView(text: app.createAccount)
                Spacer()
            }
            
            DefaultButtonView(title: "Готово") {
                sections.append(index+1)
            }
        }
        .sectionModifiers()
    }
    
    func openFinder(at path: String) {
        let url = URL(fileURLWithPath: path)
        NSWorkspace.shared.open(url)
    }
}
