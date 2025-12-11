//
//  MainViewModel.swift
//  UpdateApp
//
//  Created by Main on 28.07.2025.
//

import SwiftUI
import Combine

struct TaskWebViewModel: Identifiable {
    var id: String
    var appId: String
    var newAppName: String
    var firstAppName: String
    var createAccount: String
    var transferAccount: String
    var creoLink: String
    var devLink: String
    var webviewDomain: String
    var devComp: String
    var isDone: Bool
}

@Observable class MainViewModel {
    var tasksWEBList: [TaskWebViewModel] = []
    
    func getTasksWEBList(){
        FirebaseServices().getDocuments(collection: "taskwebview") { docs in
            var array: [TaskWebViewModel] = []
                        
            docs.forEach{doc in
                let id = doc.documentID
                let appId = doc["appId"] as? String
                let newAppName = doc["newAppName"] as? String
                let firstAppName = doc["firstAppName"] as? String
                let createAccount = doc["createAccount"] as? String
                let transferAccount = doc["transferAccount"] as? String
                let creoLink = doc["creoLink"] as? String
                let devLink = doc["devLink"] as? String
                let webviewDomain = doc["webviewDomain"] as? String
                let devComp = doc["devComp"] as? String
                let isDone = doc["isDone"] as? Bool
                
                array.append(
                    TaskWebViewModel(
                        id: id,
                        appId: appId ?? "",
                        newAppName: newAppName ?? "",
                        firstAppName: firstAppName ?? "",
                        createAccount: createAccount ?? "",
                        transferAccount: transferAccount ?? "",
                        creoLink: creoLink ?? "",
                        devLink: devLink ?? "",
                        webviewDomain: webviewDomain ?? "",
                        devComp: devComp ?? "",
                        isDone: isDone ?? false
                    )
                )
            }
            self.tasksWEBList = array
        }
    }
}
