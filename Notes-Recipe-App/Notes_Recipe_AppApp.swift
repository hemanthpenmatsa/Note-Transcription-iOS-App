//
//  Notes_Recipe_AppApp.swift
//  Notes-Recipe-App
//
//  Created by Hemanth Penmatsa on 5/8/25.
//

import SwiftUI

@main
struct Notes_Recipe_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
