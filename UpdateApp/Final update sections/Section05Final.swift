//
//  Section05Final.swift
//  MainCRM
//
//  Created by Main on 24.03.2025.
//

import SwiftUI

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
            
            Text("Собираем билд, заливаем обновление")
                .font(.title2)
            HStack {
                Text("Загружаем собранный билд для приложения \(app.appId) на аккаунт - \(app.createAccount)")
                Spacer()
            }
            
            DefaultButtonView(title: "Готово") {
                sections.append(index+1)
            }
        }
        .sectionModifiers()
    }
}
