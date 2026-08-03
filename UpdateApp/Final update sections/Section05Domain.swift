//
//  Section05Domain.swift
//  UpdateApp
//
//  Created by Nakhodka on 03.08.2026.
//

import SwiftUI

struct Section05Domain: View {
        var app: TaskWebViewModel
        @State private var isPresented: Bool = false
        @Binding var sections: [Int]
        @State private var isFailure: Bool = false
        @State private var isDate: Bool = false
        @State private var isFilesExistError: Bool = false
        @State private var isFirebaseExist: Bool = false
        var index: Int
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack{
                    Spacer()
                    Image(systemName: "05.square")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                Text("Настройки Webview")
                    .font(.title)
                    .padding(.bottom, 20)
                
                HStack{
                    Text("Открываем настройку ссылки для Webview")
                    if let link = URL(string: app.domainLink + "/change.php?file=" + app.appId) {
                        Link(destination: link) {
                            Text("Открыть сервер")
                        }
                    }
                }
                
                HStack{
                    Text("Ссылка для Webview: ")
                    CopyTextView(text: "https://1wjpja.top")
                }
                
                HStack{
                    Text("Пароль: ")
                    CopyTextView(text: "CaHaLviff6")
                }
                .padding(.bottom, 10)
                
                DefaultButtonView(title: "Готово") {
                    sections.append(index+1)
                }
            }
            .sectionModifiers()
        }
        
        func getAppShortName() -> String {
            return String(app.firstAppName.prefix(4))
        }
    }
