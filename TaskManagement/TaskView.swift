//
//  TaskView.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/24.
//

import SwiftUI

struct TaskView: View {
    @Bindable var task: Task
    @Binding var path: NavigationPath
    
    var body: some View {
        Form {
            TextField("Description", text: $task.taskDescription)
            TextField("Status", text: $task.status)
            
            Section("Comments") {
                if task.comments.isEmpty {
                    Text("No comments available")
                }
                
                ForEach(task.comments) { comment in
                    NavigationLink(value: comment) {
                        Text(comment.commentDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    let path = NavigationPath.init()
    return TaskView(task: Task(), path: Binding.constant(path))
}
