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
                Text("Перемещаем приложение в корень и запускаем его")
                CopyTextView(text: "cd ~/Apps")
                CopyTextView(text: "mv \(app.firstAppName) ~/")
                CopyTextView(text: "cd ~/\(app.firstAppName)")
                CopyTextView(text: "npm i")
                CopyTextView(text: "open -a /Applications/Android\\ Studio.app")
                CopyTextView(text: "npx react-native start")
                Spacer()
            }
            HStack {
                Text("В Android studio находим приложение ")
                CopyTextView(text: "\(app.firstAppName)")
                Text(" и запускаем его")
                Spacer()
            }
            
            DefaultButtonView(title: "Готово") {
                sections.append(index+1)
            }
        }
        .sectionModifiers()
    }
}
