//
//  AppTSX.swift
//  UpdateApp
//
//  Created by Main on 28.07.2025.
//

import SwiftUI

struct AppTSX: View {
    var appName: String
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
    
    func start(){
        let filePath = "/Users/\(NSUserName())/\(appName)/App.tsx"
        
        if fileManager.fileExists(atPath: filePath) {
            
            let fileURL = URL(fileURLWithPath: filePath)
            let replacedString = """
// Скопировать код App.tsx
import React, {useRef, useState, useEffect} from 'react';
import {ActivityIndicator, StyleSheet, View, Dimensions,BackHandler, NativeModules} from 'react-native';
import WebView from 'react-native-webview';
import App1 from './App1';
import analytics from '@react-native-firebase/analytics';
import firestore from '@react-native-firebase/firestore';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { PlayInstallReferrer } from 'react-native-play-install-referrer';
import {PermissionsAndroid} from 'react-native';
PermissionsAndroid.request(PermissionsAndroid.PERMISSIONS.POST_NOTIFICATIONS);

const WebScreen = ({setShowWeb, webLink}) => {
const webViewRef = useRef()
const [indicator, setIndicator] = useState(true);

const handleBackButtonPress = () => {
try {
webViewRef.current?.goBack()
} catch (err) {
console.log("[handleBackButtonPress] Error : ", err.message)
}

return true;
}

useEffect(() => {
BackHandler.addEventListener("hardwareBackPress", handleBackButtonPress)
return () => {};
}, []);

return (
<View style={{flex: 1, paddingTop: 25}}>
<WebView
source={{
uri: webLink,
}}
ref={webViewRef}
onMessage={event => {}}
javaScriptEnabled={true}
onLoadEnd={syntheticEvent => {
setIndicator(false);
}}
allowsInlineMediaPlayback={true}
onHttpError={syntheticEvent => {
  console.log("ERROR");

    const {nativeEvent} = syntheticEvent;
    if(nativeEvent.statusCode > 400) setShowWeb(false)
}}

onError={err => {
  if(!err.nativeEvent.loading) setShowWeb(false)
console.log(err);
}}
/>
{indicator && (
<View style={styles.loader}>
<ActivityIndicator size="large" />
</View>
)}
</View>
);
};

function App() {
    const [showWeb, setShowWeb] = useState(null)
    const [webLink, setWebLink] = useState('')
    const [webDefaultLink, setWebDefaultLink] = useState('')
    const [webASO, setWebASO] = useState('')
    const [webUAC, setWebUAC] = useState('')
    const [installReferrer, setInstallReferrer] = useState('')

    async function getFirebase(){
        const linksCollection = await firestore().collection('links').doc('linkObj').get();
        const link = await linksCollection.data().link
        const aso = await linksCollection.data().aso
        const uac = await linksCollection.data().uac
        if(link) setWebDefaultLink(link)
        if(aso) setWebASO(aso)
        if(uac) setWebUAC(uac)
        if(!link && !aso && !uac) {
            setShowWeb(false)
        }else {
            getData()
        }
    }

    const getInstallReferrer = async () => {
        await PlayInstallReferrer.getInstallReferrerInfo((installReferrerInfo, error) => {
          if (!error) {
            setInstallReferrer(installReferrerInfo.installReferrer);
            storeData(installReferrerInfo.installReferrer)
          } else {
            console.log("Failed to get install referrer info!");
          }
        });
    }

    const storeData = async (value) => {
      try {
        await AsyncStorage.setItem('installReferrer', value);
      } catch (e) {
        console.log("Error - ", e)
      }
    };

    const getData = async () => {
      try {
        const value = await AsyncStorage.getItem('installReferrer');
        if (value !== null) {
            console.log(value)
            setInstallReferrer(value)
        }else {
            getInstallReferrer()
        }
      } catch (e) {
        console.log("Error - ", e)
      }
    };

    useEffect(() => {
        getFirebase()
    }, [])

    useEffect(() => {
        if (installReferrer) {
            const regex = /gclid=/;
            let match = regex.test(installReferrer);
            if(match && webUAC){
                const gclid = getGclidFromReferer()
                let newLink = webUAC
                newLink = newLink.replace('{gclid}', `${gclid}`)
                gclid ? setWebLink(newLink) : setWebLink(webUAC)
            }else if(match && webASO){
                setWebLink(webASO)
            }else if(webASO){
                setWebLink(webASO)
            }else {
                setWebLink(webDefaultLink)
            }
        }
    }, [installReferrer])

    const getGclidFromReferer = () => {
      let gclid = installReferrer.split('gclid=')[1]
      if(gclid) gclid = gclid.split('&')[0]

      return gclid || null
    }

    useEffect(() => {
        if (webLink) {
            setShowWeb(true)
        }
    }, [webLink])

    const renderView = () => {
        if (showWeb == null) {
            return <View style={{flex:1, justifyContent:'center'}}><ActivityIndicator size='large' /></View>
        }
        if (showWeb) {
            return <WebScreen setShowWeb={setShowWeb} webLink={webLink} />
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
