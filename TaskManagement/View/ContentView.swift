//
//  ContentView.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/24.
//

import SwiftUI

struct ContentView: View {
    @State private var path = [Project]()
    @Bindable var projects = Projects()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(projects.items) { project in
                    NavigationLink(destination: ProjectView(project: project, projects: projects, exhibitionMode: .update)) {
                        VStack(alignment: .leading) {
                            Text(project.name)
                            Text(project.projectDescription)
                        }
                    }
                }.onDelete(perform: deleteProject)
            }
            .toolbar {
                Button("Add Project", action: addDestination)
            }
            .navigationDestination(for: Project.self, destination: { p in
                ProjectView(project: p, projects: projects, exhibitionMode: .create)
            })
            .navigationTitle("Projects")
        }
    }
}

//MARK: private functions
private extension ContentView {
    func deleteProject(indexSet: IndexSet) {
        for index in indexSet {
            projects.items.remove(at: index)
        }
    }
    
    func addDestination() {
        let project = Project()
        path = [project]
    }
}

#Preview {
    ContentView()
}
