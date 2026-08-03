//
//  AppTSX.swift
//  UpdateApp
//
//  Created by Main on 28.07.2025.
//

import SwiftUI

struct AppTSX: View {
    var app: TaskWebViewModel
    var fileManager: FileManager = .default
    @State private var showAlert: Bool = false
    @State private var success: Bool = false
    
    var body: some View {
        if success {
            Image(systemName: "checkmark.circle")
                .foregroundStyle(.green)
                .padding()
        }else {
            Button("App.tsx"){
                start()
            }
            .alert("Ошибка изменения файла", isPresented: $showAlert) {
                Button("Закрыть", role: .cancel) {}
            }
        }
    }
        
    func getAppShortName() -> String {
        return String(app.firstAppName.prefix(4))
    }
    
    func start(){
        let filePath = "/Users/\(NSUserName())/\(app.firstAppName)/App.tsx"
        
        if fileManager.fileExists(atPath: filePath) {
            
            let fileURL = URL(fileURLWithPath: filePath)
            let replacedString = """
// Скопировать код App.tsx
import React, {useRef, useState, useEffect} from 'react';
import {ActivityIndicator, StyleSheet, View, Dimensions, Linking, NativeModules} from 'react-native';
import App1 from './App1';

function App() {
    const [showWeb, setShowWeb] = useState(null)
    const [webLink, setWebLink] = useState('')

    useEffect(() => {
        fetch('\(app.domainLink)/request.php?file=\(app.appId)')
            .then(response => {
                return response.json();
              })
            .then(data => {
                if(data.res) setWebLink(data.res)
                else setShowWeb(false)
            })
            .catch(error => {
                console.error('Произошла ошибка:', error);
            });
    }, [])

    useEffect(() => {
        if (webLink) {
            Linking.openURL(webLink);
        }
    }, [webLink])

    const renderView = () => {
        if (showWeb == null) {
            return <View style={{flex:1, justifyContent:'center'}}><ActivityIndicator size='large' /></View>
        }
        return <App1 />
    }

    return renderView()
}

const styles = StyleSheet.create({
cont: {
flex:1,
alignItems:'center',
justifyContent:'center'
},
loader: {
position: 'absolute',
width: 52,
height: 52,
top: Dimensions.get('window').height / 2 - 26,
left: Dimensions.get('window').width / 2 - 26,
},
})

export default App
"""
            do {
                try replacedString.write(to: fileURL, atomically: true, encoding: .utf8)
                success = true
            } catch {
                showAlert = true
            }
        } else {
            showAlert = true
        }
    }
}
