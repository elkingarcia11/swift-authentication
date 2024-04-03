//
//  swift_authenticationApp.swift
//  swift-authentication
//
//  Created by Elkin Garcia on 4/3/24.
//

import SwiftUI

@main
struct swift_authenticationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
