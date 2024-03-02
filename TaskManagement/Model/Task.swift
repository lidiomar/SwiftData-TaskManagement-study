//
//  Task.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/24.
//

import Foundation

@Observable
class Task: Hashable, Identifiable {
    let id = UUID()
    var taskDescription: String
    var comments: [Comment]
    var status: String
    
    init(taskDescription: String = "",
         comments: [Comment] = [],
         status: String = "") {
        self.taskDescription = taskDescription
        self.comments = comments
        self.status = status
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
