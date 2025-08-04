//
//  Section03Server.swift
//  MainCRM
//
//  Created by Main on 24.03.2025.
//

import SwiftUI

struct Section03Server: View {
    var app: TaskWebViewModel
    @State private var isPresented: Bool = false
    @Binding var sections: [Int]
    @State private var isFailure: Bool = false
    @State private var isDate: Bool = false
    var index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                Image(systemName: "03.square")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            Text("Настройки Firebase")
                .font(.title)
                .padding(.bottom, 20)
            
            HStack{
                Text("Открываем трансферный аккаунт - ")
                CopyTextView(text: "\(app.transferAccount)")
            }
            
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
                openFinder(at: "/Users/\(NSUserName())/\(app.firstAppName)/android/app")
            }
            
            HStack{
                Text("Дата увеличена на год?")
                Button("Да"){ isDate = true }
            }
            
            if isDate {
                HStack{
                    Text("Collection ID: ")
                    CopyTextView(text: "links")
                }
                HStack{
                    Text("Document ID: ")
                    CopyTextView(text: "linkObj")
                }
                HStack{
                    Text("Field: ")
                    CopyTextView(text: "link")
                }
                HStack{
                    Text("String: ")
                    CopyTextView(text: "https://1wjpja.top")
                }
                    .padding(.bottom, 10)
                
                DefaultButtonView(title: "Готово") {
                    sections.append(index+1)
                }
            }
        }
        .sectionModifiers()
    }
    
    func openFinder(at path: String) {
        let url = URL(fileURLWithPath: path)
        NSWorkspace.shared.open(url)
    }
}
