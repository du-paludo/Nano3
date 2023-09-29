//
//  Nano_3App.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import SwiftUI

@main
struct Nano_3App: App {
//    init() {
//        PlacesManager.readJSONFile()
//    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.light)
        }
    }
}
