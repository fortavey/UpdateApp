//
//  Section01OpenApp.swift
//  MainCRM
//
//  Created by Main on 24.03.2025.
//

import SwiftUI
import Cocoa

struct Section01OpenApp: View {
    var app: TaskWebViewModel
    @Binding var sections: [Int]
    var index: Int
    
    func openFinder(at path: String) {
        let url = URL(fileURLWithPath: path)
        NSWorkspace.shared.open(url)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                Image(systemName: "01.square")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            Text("Запуск приложение на компьютере - \(app.devComp)")
                .font(.title)
            
            VStack(alignment: .leading) {
                Text("Перемещаем приложение в корень")
                CopyTextView(text: "cd ~/Apps")
                CopyTextView(text: "mv \(app.firstAppName) ~/")
                CopyTextView(text: "cd ~/\(app.firstAppName)")
                CopyTextView(text: "npx react-native start")
                Text(" и запускаем его")
                Spacer()
            }
            HStack {
                Text("Открываем Android studio. Находим приложение ")
                CopyTextView(text: "\(app.firstAppName)")
                Text(" и запускаем его")
                Spacer()
            }
            HStack {
                Text("Запуск через терминал. Вводим команду")
                CopyTextView(text: "open -a /Applications/Android\\ Studio.app")
                Spacer()
            }
            Text("Создание Firebase")
                .font(.title)
                .padding(.bottom, 20)
            Text("Открываем трансферный аккаунт - \(app.transferAccount)")
            HStack{
                Text("Создаем профиль Firebase: ")
                CopyTextView(text: "\(app.newAppName)-\(app.firstAppName)")
            }
            HStack{
                Text("ID пакета: ")
                CopyTextView(text: "\(app.appId)")
            }
            Text("Перемещаем файл google-services.json в app")
            Button("Открыть папку app"){
                openFinder(at: "/Users/main/FreedomSweetHaven/android/app")
            }
            
            DefaultButtonView(title: "Готово") {
                sections.append(index+1)
            }
        }
        .sectionModifiers()
    }
}
