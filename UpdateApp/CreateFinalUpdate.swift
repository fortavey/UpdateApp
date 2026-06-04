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
    @State private var isDisabled: Bool = false
    
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
                if sections.contains(7) {Section04AddIcon(appName: app.firstAppName, app: app, sections: $sections, index: 7)}
                if sections.contains(8) {Section05Final(app: app, sections: $sections, index: 8)}
                if sections.contains(9) {
                    VStack{
                        Text("Завершение обновления приложения")
                            .font(.title)
                        
                        Button {
                            isDisabled = true
                            setIsDoneFire()
                        } label: {
                            Text("Готово")
                        }
                        .frame(height: 50)
                        .padding()
                        .padding(.bottom, 30)
                        .disabled(isDisabled)
                        
                    }
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    func setIsDoneFire(){
        FirebaseServices().updateDocument(id: app.id,
                                          collection: "taskwebview",
                                          fields: ["isDone" : true]) { result in
            if result {
                mainVM.updatedList.insert(app.firstAppName)
                addAppNameFire()
            }else {
                print("Ошибка обновления трастового аккаунта")
                isDisabled = false
            }
        }
    }
    
    func addAppNameFire(){
        FirebaseServices().updateDocument(id: MainConfig.comp,
                                          collection: "updatedApps",
                                          fields: ["list" : Array(mainVM.updatedList)]) { result in
            if result {
                mainVM.getTasksWEBList()
                mainVM.getUpdatedList()
                self.presentationMode.wrappedValue.dismiss()
            }else {
                print("Ошибка обновления готовности UAC")
                isDisabled = false
            }
        }
    }
}
