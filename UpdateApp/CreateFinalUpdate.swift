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
                if sections.contains(2) {Section02VSCode(app: app, sections: $sections, index: 2)}
                if sections.contains(3) {Section03Server(app: app, sections: $sections, index: 3)}
                if sections.contains(4) {Section04TryWebview(app: app, sections: $sections, index: 4)}
                if sections.contains(5) {Section05Final(app: app, sections: $sections, index: 5)}
                if sections.contains(6) {
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
