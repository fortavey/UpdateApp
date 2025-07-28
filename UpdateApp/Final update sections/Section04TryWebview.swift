//
//  Section04TryWebview.swift
//  MainCRM
//
//  Created by Main on 24.03.2025.
//

import SwiftUI

struct Section04TryWebview: View {
    var app: TaskWebViewModel
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
            Text("Проверяем Webview")
                .font(.title)
            HStack {
                Text("Запускаем приложение, проверяем работу Webview")
                Spacer()
            }
            
            DefaultButtonView(title: "Готово") {
                sections.append(index+1)
            }
        }
        .sectionModifiers()
    }
}
