//
//  Section03CopyFiles.swift
//  UpdateApp
//
//  Created by MiniA on 25.01.2026.
//

import SwiftUI

struct Section03CopyFiles: View {
    @Binding var sections: [Int]
    @State private var isFilesExistError = false
    @State private var isZipExistError = false
    @State private var isComplete = false
    var appName: String
    var devLink: String
    var index: Int
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                HStack{
                    Spacer()
                    Image(systemName: "03.square")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                Text("Скачиваем файлы в проект")
                    .font(.title)
                
                if let link = URL(string: devLink) {
                    if devLink.matches("https"){
                        Link(destination: link) {
                            HStack{
                                Text("Скачать")
                                    .padding(.bottom, 10)
                                Image("GoogleDriveIcon")
                                    .resizable()
                                    .frame(width: 17, height: 17)
                            }
                        }
                    }
                }
                
                Button("Распаковать"){
                    unzip()
                }
                .alert("Архив проекта отсутствует в папке Загрузки", isPresented: $isZipExistError) {
                    Button("Закрыть", role: .cancel) {}
                }
                
                Button("Переместить файлы"){
                    moveFiles()
                }
                .alert("Файл проекта отсутствуют либо не распакованы", isPresented: $isFilesExistError) {
                    Button("Закрыть", role: .cancel) {}
                }
                Button("Переместить файл ключа"){
                    isComplete = true
                    let fileManager = FileManager.default
                    let filePath = "/Users/\(NSUserName())/Downloads/\(appName.lowercased()).keystore"

                    if fileManager.fileExists(atPath: filePath) {
                        do {
                            try FileManager.default.moveItem(atPath: "/Users/\(NSUserName())/Downloads/\(appName.lowercased()).keystore", toPath: "/Users/\(NSUserName())/\(appName)/android/app/\(appName.lowercased()).keystore")
                        }catch {
                            print("Error moving icon: \(error)")
                        }
                    }else {
                        isFilesExistError = true
                    }
                }
                .alert("Файл ключей не существует", isPresented: $isFilesExistError) {
                    Button("Закрыть", role: .cancel) {}
                }
                
                if isComplete || isFilesMoved() {
                    DefaultButtonView(title: "Готово") {
                        sections.append(index+1)
                    }
                }
            }
            
            Spacer()
        }
        .sectionModifiers()
    }
    
    func isFilesMoved() -> Bool {
        let fileManager = FileManager.default
        let filePath = "/Users/\(NSUserName())/\(appName)/App1.tsx"
        
        return fileManager.fileExists(atPath: filePath)
    }
    
    func moveFiles() {
        let fileManager = FileManager.default
        let filePath = "/Users/\(NSUserName())/Downloads/\(appName)/App.tsx"

        if fileManager.fileExists(atPath: filePath) {
            do {
                try fileManager.removeItem(atPath: "/Users/\(NSUserName())/\(appName)/App.tsx")
                try fileManager.moveItem(atPath: "/Users/\(NSUserName())/Downloads/\(appName)/src", toPath: "/Users/\(NSUserName())/\(appName)/src")
                try fileManager.moveItem(atPath: "/Users/\(NSUserName())/Downloads/\(appName)/App.tsx", toPath: "/Users/\(NSUserName())/\(appName)/App.tsx")
                try fileManager.moveItem(atPath: "/Users/\(NSUserName())/Downloads/\(appName)/App1.tsx", toPath: "/Users/\(NSUserName())/\(appName)/App1.tsx")
                isComplete = true
            }catch {
                print("Error moving files: \(error)")
            }
        }else {
            isFilesExistError = true
        }
    }
    
    func unzip() {
        let fileManager = FileManager.default
        let filePath = "/Users/\(NSUserName())/Downloads/\(appName).zip"
        
        if fileManager.fileExists(atPath: filePath) {
            Helpers().openTerminal(content: "cd Downloads \ntar -xvf \(appName).zip")
        }else {
            isZipExistError = true
        }
    }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
