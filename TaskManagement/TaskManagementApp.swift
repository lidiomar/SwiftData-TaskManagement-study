//
//  TaskManagementApp.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/24.
//

import SwiftUI
import SwiftData

@main
struct TaskManagementApp: App {
    
    let container: ModelContainer = {
        // Set up default location in Application Support directory
        let fileManager = FileManager.default
        let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let directoryURL = appSupportURL.appendingPathComponent("Example")
        
        // Set the path to the name of the store you want to set up
        let fileURL = directoryURL.appendingPathComponent("Example.store")
        try! FileManager.default.setAttributes([FileAttributeKey.protectionKey: FileProtectionType.complete], ofItemAtPath: fileURL.path)

        // Create a schema for your model (**Item 1**)
        let schema = Schema([Project.self])
        
        do {
            // This next line will create a new directory called Example in Application Support if one doesn't already exist, and will do nothing if one already exists, so we have a valid place to put our store
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)

            // Create our `ModelConfiguration` (**Item 3**)
            let defaultConfiguration = ModelConfiguration("Example", schema: schema, url: fileURL)
            
            do {
                return try ModelContainer(
                    for: schema,
                    configurations: defaultConfiguration
                )
             } catch {
                fatalError("Could not initialise the container…")
            }
        } catch {
            fatalError("Could not find/create Example folder in Application Support")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(container)
    }
}
