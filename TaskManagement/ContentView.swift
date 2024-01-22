//
//  ContentView.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query var projects: [Project]
    
    var body: some View {
        let _ = print(modelContext.sqliteCommand)
        NavigationStack {
            List {
                ForEach(projects) { project in                    
                    NavigationLink(destination: ProjectView(project: project, exhibitionMode: .update)) {
                        VStack(alignment: .leading) {
                            Text(project.name)
                            Text(project.projectDescription)
                        }
                    }
                }.onDelete(perform: deleteProject)
            }.toolbar {
                addProjectNavigationLink()
            }
        }.onAppear {
            modelContext.autosaveEnabled = false
        }
    }
    
    private func deleteProject(indexSet: IndexSet) {
        for index in indexSet {
            let project = projects[index]
            modelContext.delete(project)
        }
        do {
            try modelContext.save()
        } catch {
            fatalError("An error occurred when deleting a project: \(error)")
        }
    }
    
    private func addProjectNavigationLink() -> some View {
        let projectView = ProjectView(project: Project(), exhibitionMode: .create)
        return NavigationLink(destination: projectView) {
            Text("Add project")
        }
        .buttonStyle(.borderless)
    }
}

#Preview {
    ContentView()
}
