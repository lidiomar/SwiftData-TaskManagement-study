//
//  ProjectView.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/24.
//

import SwiftUI
import SwiftData

struct ProjectView: View {
    @Environment(\.modelContext) var modelContext: ModelContext
    @Environment(\.dismiss) var dismiss
    @Bindable var project: Project
    var exhibitionMode: ExhibitionMode
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $project.name)
                TextField("Description", text: $project.projectDescription)
                DatePicker("Start Date", selection: $project.startDate)
                DatePicker("End Date", selection: $project.endDate)
                
                Section {
                    ForEach(project.tasks) { task in
                        Text(task.taskDescription)
                    }
                }
            }
            
            Button(buttonDescription(), action: addNewProject)
        }.toolbar {
            addTaskNavigationLink()
        }
    }
    
    private func addTaskNavigationLink() -> some View {
        let taskView = TaskView(project: project)
        return NavigationLink(destination: taskView) {
            Text("Add task")
        }
        .buttonStyle(.borderless)
    }
    
    private func buttonDescription() -> String {
        switch exhibitionMode {
        case .create:
            return "Create"
        case .update:
            return "Update"
        }
    }
    
    private func addNewProject() {
        modelContext.insert(project)
        dismiss()
    }
}
