//
//  CreateFinalUpdate.swift
//  UpdateApp
//
//  Created by Main on 28.07.2025.
//

import SwiftUI

struct CreateFinalUpdate: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var sections: [Int] = [1]
    var app: TaskWebViewModel
    var mainVM: MainViewModel
    
    var body: some View {
        VStack {
            Text("Создание финальной версии приложения \(app.firstAppName)")
            List {
                
                if sections.contains(1) {Section01OpenApp(app: app, sections: $sections, index: 1)}
                if sections.contains(2) {Section02InstallDeps(appName: app.firstAppName, sections: $sections, index: 2)}
                if sections.contains(3) {Section03CopyFiles(sections: $sections, appName: app.firstAppName, devLink: app.devLink, index: 3)}
                if sections.contains(4) {Section04VSCode(app: app, sections: $sections, index: 4)}
                if sections.contains(5) {Section05Server(app: app, sections: $sections, index: 5)}
                if sections.contains(6) {Section04TryWebview(app: app, sections: $sections, index: 6)}
                if sections.contains(7) {Section05Final(app: app, sections: $sections, index: 7)}
                if sections.contains(8) {
                    VStack{
                        Text("Завершение обновления приложения")
                            .font(.title)
                        
                        Button {
                            FirebaseServices().updateDocument(id: app.id,
                                                              collection: "apps",
                                                              fields: ["isUACReady" : true]) { result in
                                if result {
                                    
                                }else {
                                    print("Ошибка обновления готовности UAC")
                                }
                            }
                            FirebaseServices().updateDocument(id: app.id,
                                                              collection: "taskwebview",
                                                              fields: ["isDone" : true]) { result in
                                if result {
                                    mainVM.getTasksWEBList()
                                    self.presentationMode.wrappedValue.dismiss()
                                }else {
                                    print("Ошибка обновления трастового аккаунта")
                                }
                            }
                        } label: {
                            Text("Готово")
                        }
                        .frame(height: 50)
                        .padding()
                        .padding(.bottom, 30)
                        
                    }
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
