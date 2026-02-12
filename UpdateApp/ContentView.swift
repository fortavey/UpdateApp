//
//  ContentView.swift
//  UpdateApp
//
//  Created by Main on 26.07.2025.
//  Update 08.02.2026

import SwiftUI

struct ContentView: View {
    @State private var mainVM: MainViewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            HStack{
                Text("Финальное обновление")
                    .font(.title2)
                .padding()
                Button("Сформировать список"){
                    mainVM.getTasksWEBList()
                }
                Spacer()
                Text("(12.02.2026)")
                    .font(.title3)
                    .padding()
            }
            List(mainVM.tasksWEBList
                .filter{ $0.isDone == false }
                .filter{ app in
                    if MainConfig.comp == "ALL" {
                        return true
                    }
                    if MainConfig.comp == "ANNA" {
                        return app.devComp == "ANNA"
                    }else {
                        return app.devComp != "ANNA"
                    }
                }
            ){ app in
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
