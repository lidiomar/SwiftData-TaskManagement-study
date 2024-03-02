//
//  ProjectView.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/24.
//

import SwiftUI

struct ProjectView: View {
    //MARK: Environment property wrappers.
    @Environment(\.dismiss) var dismiss
    
    @Bindable var project: Project
    @Bindable var projects: Projects
    var exhibitionMode: ExhibitionMode
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $project.name)
                TextField("Description", text: $project.projectDescription)
                DatePicker("Start Date", selection: $project.startDate)
                DatePicker("End Date", selection: $project.endDate)
                
                Section("Tasks") {
                    if !project.tasks.isEmpty {
                        ForEach(project.tasks) { task in
                            NavigationLink(destination: TaskView(project: project,
                                                                 selectedTask: task, 
                                                                 projects: projects,
                                                                 exhibitionMode: .update)) {
                                Text(task.taskDescription)
                            }
                        }.onDelete(perform: deleteTask)
                    } else {
                        Text("No tasks created.")
                    }
                }
            }
            Button(buttonDescription(), action: addNewProject)
        }.toolbar {
            addTaskNavigationLink()
        }.navigationTitle("Project")
    }
}

//MARK: private functions
private extension ProjectView {
    func deleteTask(indexSet: IndexSet) {
        for index in indexSet {
            let task = project.tasks[index]
            project.tasks.remove(at: index)
        }
    }
    
    func addTaskNavigationLink() -> some View {
        let taskView = TaskView(project: project, selectedTask: Task(), projects: projects, exhibitionMode: .create)
        return NavigationLink(destination: taskView) {
            Text("Add task")
        }
        .buttonStyle(.borderless)
    }
    
    func buttonDescription() -> String {
        switch exhibitionMode {
        case .create:
            return "Create"
        case .update:
            return "Update"
        }
    }
    
    func addNewProject() {
        if exhibitionMode == .create {
            projects.items.append(project)
        }
        
        dismiss()
    }
}
