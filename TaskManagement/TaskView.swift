//
//  TaskView.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/24.
//

import SwiftUI
import SwiftData

struct TaskView: View {
    @Bindable var project: Project
    @Bindable var selectedTask: Task
    @Environment(\.modelContext) var modelContext: ModelContext
    @Environment(\.dismiss) var dismiss
    var exhibitionMode: ExhibitionMode
    
    var body: some View {
        VStack {
            Form {
                TextField("Description", text: $selectedTask.taskDescription)
                TextField("Status", text: $selectedTask.status)
            }
            
            Button("Save", action: {
                if exhibitionMode == .create {
                    let task = Task(taskDescription: selectedTask.taskDescription,
                                    comments: [],
                                    status: selectedTask.status)
                    
                    modelContext.insert(task)
                    project.tasks.append(task)
                }
                dismiss()
            })
        }
    }
}
