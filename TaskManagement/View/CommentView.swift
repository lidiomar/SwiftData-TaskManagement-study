//
//  CommentView.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 22/01/24.
//

import SwiftUI

struct CommentView: View {
    //MARK: Bindable property wrappers.
    @Bindable var task: Task
    @Bindable var selectedComment: Comment
    
    //MARK: Environment property wrappers.
    @Environment(\.dismiss) var dismiss
    
    var exhibitionMode: ExhibitionMode
    
    var body: some View {
        VStack {
            Form {
                TextField("", text: $selectedComment.commentDescription)
            }
            Button("Save", action: saveCommentState)
        }.navigationTitle("Comment")
    }
}

private extension CommentView {
    func saveCommentState() {
        if exhibitionMode == .create {
            let comment = Comment(commentDescription: selectedComment.commentDescription)
            task.comments.append(comment)
        }
        dismiss()
    }
}
