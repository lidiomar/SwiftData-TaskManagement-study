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
                
                if !selectedTask.comments.isEmpty {
                    Section("Comments") {
                        ForEach(selectedTask.comments) { comment in
                            NavigationLink(destination: CommentView(task: selectedTask,
                                                                    selectedComment: comment,
                                                                    exhibitionMode: .update)) {
                                Text(comment.commentDescription)
                            }
                        }
                    }
                }
            }
            
            Button("Save", action: {
                if exhibitionMode == .create {
                    let task = Task(taskDescription: selectedTask.taskDescription,
                                    comments: [],
                                    status: selectedTask.status)
                    
                    modelContext.insert(task)
                    task.comments = selectedTask.comments
                    project.tasks.append(task)
                }
                dismiss()
            })
        }.toolbar {
            addCommentNavigationLink()
        }
    }
    
    private func addCommentNavigationLink() -> some View {
        let commentView = CommentView(task: selectedTask,
                                      selectedComment: Comment(),
                                      exhibitionMode: .create)
        
        return NavigationLink(destination: commentView) {
            Text("Add comment")
        }
        .buttonStyle(.borderless)
    }
}
