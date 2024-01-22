//
//  TaskView.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/24.
//

import SwiftUI
import SwiftData

struct TaskView: View {
    @State private var description: String = ""
    @State private var status: String  = ""
    @Bindable var project: Project
    @Environment(\.modelContext) var modelContext: ModelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Form {
                TextField("Description", text: $description)
                TextField("Status", text: $status)
            }
            
            Button("Save", action: {
                let task = Task(taskDescription: description, comments: [], status: status)
                modelContext.insert(task)
                project.tasks.append(task)
                dismiss()
            })
        }
    }
}
