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
            
            HStack{
                Text("Дата увеличена на год?")
                Button("Да"){ isDate = true }
            }
            
            if isDate {
                HStack{
                    Text("База: ")
                    CopyTextView(text: "links")
                }
                HStack{
                    Text("Обьект: ")
                    CopyTextView(text: "linkObj")
                }
                HStack{
                    Text("Поле: ")
                    CopyTextView(text: "link")
                }
                HStack{
                    Text("Ссылка: ")
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
}
