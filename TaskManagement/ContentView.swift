//
//  ContentView.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/24.
//

import SwiftUI
import SwiftData

enum ExhibitionMode {
    case create
    case update
}

enum TaskManagementScreen {
    case project(exhibitionMode: ExhibitionMode)
}

struct TaskManagementPath: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(model)
    }
    
    static func == (lhs: TaskManagementPath, rhs: TaskManagementPath) -> Bool {
        return lhs.model.hashValue == rhs.model.hashValue
    }
    
    @Bindable var model: Project
    var location: TaskManagementScreen
}

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
                }
            }.toolbar {
                addProjectNavigationLink()
            }
        }
    }
    
    private func deleteProject(indexSet: IndexSet) {
        for index in indexSet {
            let project = projects[index]
            modelContext.delete(project)
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
