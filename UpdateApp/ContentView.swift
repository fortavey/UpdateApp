//
//  ContentView.swift
//  UpdateApp
//
//  Created by Main on 26.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var mainVM: MainViewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            HStack{
                Text("Финальное обновление")
                    .font(.title3)
                    .padding()
                Button("Сформировать список"){
                    mainVM.getTasksWEBList()
                }
                Spacer()
            }
            List(mainVM.tasksWEBList.filter{ $0.devComp == MainConfig.comp && $0.isDone == false }){ app in
                HStack{
                    LineItemView(text: app.appId, width: 150)
                    LineItemView(text: app.newAppName, width: 150)
                    LineItemView(text: app.createAccount, width: 150)
                    LineItemView(text: app.devComp, width: 50)
                    NavigationLink {
                        CreateFinalUpdate(app: app, mainVM: mainVM)
                    } label: {
                        Label {
                            Text("Начать")
                        } icon: {
                            Image(systemName: "arrow.right.square")
                        }
                        
                    }
                    
                }
            }
        }
    }
}
