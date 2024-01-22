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
            }
            Button(buttonDescription(), action: addNewProject)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add task", action: addNewProject)
            }
        }.onAppear {
            modelContext.autosaveEnabled = false
        }
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
        if exhibitionMode == .create {
            modelContext.insert(project)
        }
        saveProjectState()
        dismiss()
    }
    
    private func saveProjectState() {
        do {
            try modelContext.save()
        } catch {
            fatalError("An error occurred when updating a new project: \(error)")
        }
    }
}

#Preview {
    return ProjectView(project: Project(), exhibitionMode: .create)
}
