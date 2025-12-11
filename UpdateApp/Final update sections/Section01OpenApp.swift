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
            Text("Создание приложения")
                .font(.title)
            HStack {
                Text("Открываем терминал. Удостоверится что выбрана корневая папка")
                CopyTextView(text: "cd ~")
                Spacer()
            }
            Text("Вводим команду создания нового приложения:")
            CopyTextView(text: "npx @react-native-community/cli@latest init \(app.firstAppName)")
            Text("Дожидаемся окончания процесса")
            
            Text("Первый запуск приложения")
                .font(.title)
            HStack {
                Text("Работа в терминале. Переходим в папку только что созданного приложения")
                CopyTextView(text: "cd \(app.firstAppName)")
                Spacer()
            }
            Text("Вводим команду запуска приложения:")
            CopyTextView(text: "npx react-native start")
            
            Text("Запуск приложения в Andriod Studio")
                .font(.title)
            
            HStack {
                Text("Запуск через терминал. Вводим команду")
                CopyTextView(text: "open -a /Applications/Android\\ Studio.app")
                Spacer()
            }
            
            DefaultButtonView(title: "Готово") {
                sections.append(index+1)
            }
        }
        .sectionModifiers()
    }
}
