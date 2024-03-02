//
//  Project.swift
//  TaskManagement
//
//  Created by Lidiomar Fernando dos Santos Machado on 21/01/24.
//

import Foundation
import SwiftUI

@Observable
class Projects: Identifiable {
    var items: [Project]
    
    init(items: [Project] = []) {
        self.items = items
    }
}

@Observable
class Project: Identifiable, Hashable {
    var projectDescription: String
    var name: String
    var startDate: Date
    var endDate: Date
    var tasks: [Task]
    
    init(projectDescription: String = "", name: String = "", startDate: Date = .now, endDate: Date = .now, tasks: [Task] = []) {
        self.projectDescription = projectDescription
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.tasks = tasks
    }
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.projectDescription == rhs.projectDescription
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(projectDescription)
    }
}
    
