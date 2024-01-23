//
//  CommentView.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 22/01/24.
//

import SwiftUI
import SwiftData

struct CommentView: View {
    @Bindable var task: Task
    @Bindable var selectedComment: Comment
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext: ModelContext
    var exhibitionMode: ExhibitionMode
    
    var body: some View {
        VStack {
            Form {
                Section("Comments") {
                    TextField("", text: $selectedComment.commentDescription)
                }
            }
            
            Button("Save", action: {
                if exhibitionMode == .create {
                    let comment = Comment(commentDescription: selectedComment.commentDescription)
                    modelContext.insert(comment)
                    task.comments.append(comment)
                }
                dismiss()
            })
        }
    }
}
