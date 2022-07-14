//
//  StocksAppApp.swift
//  StocksApp
//
//  Created by karma on 7/14/22.
//

import SwiftUI

@main
struct StocksAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
