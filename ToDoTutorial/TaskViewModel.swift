//
//  TaskViewModel.swift
//  ToDoTutorial
//
//  Created by Charles Suddens on 16/05/24.
//

import Foundation

class TaskViewModel : ObservableObject {
    @Published var tasks : [String] = []
    
    func addTask(task: String) {
        tasks.append(task)
        saveTasks()
    }
    
    func saveTasks() {
        UserDefaults.standard.set(tasks, forKey: "tasks")
    }
    
    func loadTasks() {
        if let savedTasks = UserDefaults.standard.array(forKey: "tasks") as? [String] {
            tasks = savedTasks
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }
    
    func updateTask(at: Int, task: String) {
        guard tasks.indices.contains(at) else { return }
        tasks[at] = task
        saveTasks()
    }
}
