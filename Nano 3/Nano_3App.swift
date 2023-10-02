//
//  Nano_3App.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import SwiftUI
import SwiftData

@main
struct Nano_3App: App {
//    let persistenceController = PersistenceController.shared
 
    var body: some Scene {
        WindowGroup {
            HomeView()
                //.preferredColorScheme(.light)
                .modelContainer(for: [Place.self])
        }
    }
}

