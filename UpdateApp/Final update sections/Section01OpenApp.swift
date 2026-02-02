//
//  Section01OpenApp.swift
//  MainCRM
//
//  Created by Main on 24.03.2025.
//

import SwiftUI

struct Section01OpenApp: View {
    var app: TaskWebViewModel
    @State private var showAlert = false
    @Binding var sections: [Int]
    var index: Int
    
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

            Button("Создать"){
                Helpers().openTerminal(content: "npx @react-native-community/cli@latest init \(app.firstAppName)")
            }
            
            DefaultButtonView(title: "Готово") {
                if !isAppCreated() {
                    showAlert = true
                }else {
                    sections.append(index+1)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Ошибка"),
                    message: Text("Приложение не создано")
                )
            }
        }
        .sectionModifiers()
    }
    
    func isAppCreated() -> Bool {
        FileManager.default.fileExists(atPath: "/Users/\(NSUserName())/\(app.firstAppName)")
    }
}
