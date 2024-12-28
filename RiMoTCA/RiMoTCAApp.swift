//
//  RiMoTCAApp.swift
//  RiMoTCA
//
//  Created by Javier Calatrava on 28/12/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct RiMoTCAApp: App {
    
    static let store = Store(initialState: CharatersFeature.State()) {
        CharatersFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CharacterView(store: RiMoTCAApp.store)
        }
    }
}
