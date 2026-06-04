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
                    mainVM.getUpdatedList()
                }
                Spacer()
                VStack{
                    Text("(Update 04.06.2026)")
                        .font(.title3)
                        .padding(.horizontal, 20)
                    Text("Приложений за \(mainVM.month) - \(mainVM.updatedList.count) шт")
                        .padding(.horizontal, 20)
                    Text("(\(mainVM.updatedList.count * 100)р)")
                        .padding(.horizontal, 20)
                    
                }
                
            }
            List(mainVM.tasksWEBList
                .filter{ $0.isDone == false }
                .filter{ app in
                    if MainConfig.comp == "ALL" {
                        return true
                    }
                    if MainConfig.comp == "ANNA" {
                        return app.devComp == "ANNA"
                    }
                    if MainConfig.comp == "KRIS" {
                        return app.devComp == "KRIS"
                    }
                    return false
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
