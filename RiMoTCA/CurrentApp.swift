//
//  CurrentApp.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

@MainActor
struct CurrentApp {
    var dataManager: DataManager
    
    init(dataManager: DataManager? = nil) {
        self.dataManager = dataManager ?? DataManager()
    }
}

@MainActor
var currentApp = CurrentApp()

