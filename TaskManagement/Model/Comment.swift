//
//  Comment.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/24.
//

import Foundation

@Observable
class Comment: Hashable, Identifiable {
    var commentDescription: String
    
    init(commentDescription: String = "") {
        self.commentDescription = commentDescription
    }
    
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.commentDescription == rhs.commentDescription
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(commentDescription)
    }
}

