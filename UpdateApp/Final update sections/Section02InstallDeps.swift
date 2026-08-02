//
//  Section02InstallDeps.swift
//  UpdateApp
//
//  Created by MiniA on 25.01.2026.
//

import SwiftUI

struct Section02InstallDeps: View {
    var appName: String
    @Binding var sections: [Int]
    @State private var showAlert = false
    var index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                Image(systemName: "02.square")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            Text("Устанавливаем зависимости")
                .font(.title)
            
            Button("Установить"){
                Helpers().openTerminal(content: "cd \(appName) \nnpm i @react-native-firebase/app@25.1.0 @react-native-firebase/analytics@25.1.0 @react-native-firebase/firestore@25.1.0 react-native-webview")
            }
            
            DefaultButtonView(title: "Готово") {
                let filePath = "/Users/\(NSUserName())/\(appName)/package.json"
                let isDone = Helpers().isFileHasContent(filePath: filePath, searchString: "@react-navigation/native")
                
                if isDone {
                    sections.append(index+1)
                }else {
                    showAlert = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Ошибка"),
                    message: Text("Ошибка установки зависимостей")
                )
            }
        }
        .sectionModifiers()
    }
}
