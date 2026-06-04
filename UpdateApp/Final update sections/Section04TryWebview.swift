//
//  Section04TryWebview.swift
//  MainCRM
//
//  Created by Main on 24.03.2025.
//

import SwiftUI

struct Section04TryWebview: View {
    var app: TaskWebViewModel
    @Binding var sections: [Int]
    var index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                Image(systemName: "04.square")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            Text("Проверяем Webview")
                .font(.title)
            HStack {
                Text("Запускаем приложение, проверяем работу Webview")
                Spacer()
            }
            
            Button("Запустить Metro"){
                Helpers().openTerminal(content: "cd \(app.firstAppName) \nnpx react-native start")
            }
            
            Button("Открыть Android Studio"){
                Helpers().openTerminal(content: "open -a /Applications/Android\\ Studio.app")
            }
            
            DefaultButtonView(title: "Готово") {
                removeIcon()
                sections.append(index+1)
            }
        }
        .sectionModifiers()
    }
    
    func removeIcon() {
        let fileManager = FileManager.default
        let assetsPath = "/Users/\(NSUserName())/Downloads"
        var iconPath = ""
        do {
            let assetsContent = try fileManager.contentsOfDirectory(atPath: assetsPath)
            try assetsContent.forEach{
                if $0.contains("icon") {
                    iconPath = "\(assetsPath)/\($0)"
                    try fileManager.removeItem(atPath: iconPath)
                }
            }
        }catch {
            
        }
    }
}

struct Section04AddIcon: View {
    var appName: String
    var app: TaskWebViewModel
    @Binding var sections: [Int]
    @State private var icon = NSImage()
    var index: Int
    
    var mipmaps: [Mipmap] = [
        Mipmap(name: "mipmap-hdpi", ic_launcher_foreground: 162, ic_launcher_round: 72, ic_launcher: 72),
        Mipmap(name: "mipmap-mdpi", ic_launcher_foreground: 108, ic_launcher_round: 48, ic_launcher: 48),
        Mipmap(name: "mipmap-xhdpi", ic_launcher_foreground: 216, ic_launcher_round: 96, ic_launcher: 96),
        Mipmap(name: "mipmap-xxhdpi", ic_launcher_foreground: 324, ic_launcher_round: 144, ic_launcher: 144),
        Mipmap(name: "mipmap-xxxhdpi", ic_launcher_foreground: 432, ic_launcher_round: 192, ic_launcher: 192),
    ]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack{
                    Spacer()
                    Image(systemName: "06.square")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                Text("Добавляем иконку")
                    .font(.title)
                
                Text("Необходимо скачать иконку, переименовать ее в \"icon\" и сохранить в папку Загрузки")
                    .font(.title3)
                
                if let link = URL(string: app.creoLink) {
                    Link(destination: link) {
                        HStack{
                            Text("Открыть Google Диск")
                            Image("GoogleDriveIcon")
                                .resizable()
                                .frame(width: 17, height: 17)
                        }
                    }
                }
                
                ForEach(mipmaps, id: \.name) { mipmap in
                    VStack(alignment: .leading) {
                        SaveIconsView(appName: appName, widht: mipmap.ic_launcher, mipmapName: mipmap.name, icon: $icon)
                    }
                }
                
            
            DefaultButtonView(title: "Готово") {
                sections.append(index+1)
            }
                
            }
            .onAppear {
                if let icon = NSImage(contentsOf: URL(fileURLWithPath: getIconPath())) {
                    self.icon = icon
                }
            }
            Spacer()
        }
        .sectionModifiers()
    }
    
    func getIconPath() -> String {
        let fileManager = FileManager.default
        let assetsPath = "/Users/\(NSUserName())/Downloads"
        var iconPath = ""
        do {
            let assetsContent = try fileManager.contentsOfDirectory(atPath: assetsPath)
            assetsContent.forEach{
                if $0.contains("icon") {
                    iconPath = "\(assetsPath)/\($0)"
                }
            }
        }catch {
            
        }
        return iconPath
    }
}


struct Mipmap {
    var name: String
    var ic_launcher_foreground: CGFloat
    var ic_launcher_round: CGFloat
    var ic_launcher: CGFloat
}

struct SaveIconsView: View {
    var appName: String
    var widht: CGFloat
    var mipmapName: String
    @Binding var icon: NSImage
    @State private var showButton: Bool = true
    
    var body: some View {
        HStack{
            if icon.isValid{
                if showButton {
                    Button("Сохранить иконки"){
                        guard let round = ImageRenderer(content: round).cgImage else { return }
                        guard let launcher = ImageRenderer(content: launcher).cgImage else { return }
                        
                        let roundRep = NSBitmapImageRep(cgImage: round)
                        let launcherRep = NSBitmapImageRep(cgImage: launcher)
                        do {
                            try roundRep.representation(using:.png, properties: [:])?.write(to: URL(fileURLWithPath: "\(NSHomeDirectory())/\(appName)/android/app/src/main/res/\(mipmapName)/ic_launcher_round.png"))
                            try launcherRep.representation(using:.png, properties: [:])?.write(to: URL(fileURLWithPath: "\(NSHomeDirectory())/\(appName)/android/app/src/main/res/\(mipmapName)/ic_launcher.png"))
                            
                            showButton = false
                        }catch {
                            
                        }
                    }
                }else {
                    Image(systemName: "checkmark.circle")
                        .foregroundStyle(.green)
                        .padding()
                }
                
                round
                launcher
            }else {
                HStack{
                    Text("В папке загрузок отсутствует иконка с названием icon. Добавьте иконку и обновите список")
                    Button("Обновить"){
                        if let icon = NSImage(contentsOf: URL(fileURLWithPath: getIconPath())) {
                            self.icon = icon
                        }
                    }
                }
            }
        }
    }
    
    func getIconPath() -> String {
        let fileManager = FileManager.default
        let assetsPath = "/Users/\(NSUserName())/Downloads"
        var iconPath = ""
        do {
            let assetsContent = try fileManager.contentsOfDirectory(atPath: assetsPath)
            assetsContent.forEach{
                if $0.contains("icon") {
                    iconPath = "\(assetsPath)/\($0)"
                }
            }
        }catch {
            
        }
        return iconPath
    }
    
    var round: some View {
        ZStack {
            Image(nsImage: icon)
                .resizable()
                .frame(width: widht-10, height: widht-10)
                .clipShape(.rect(cornerRadius: widht/2))
        }
        .frame(width: widht, height: widht, alignment: .center)
    }
    var launcher: some View {
        ZStack {
            Image(nsImage: icon)
                .resizable()
                .frame(width: widht-widht*0.15, height: widht-widht*0.15)
                .clipShape(.rect(cornerRadius: widht*0.15))
        }
        .frame(width: widht, height: widht, alignment: .center)
    }
}
