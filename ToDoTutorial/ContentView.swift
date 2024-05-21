//
//  ContentView.swift
//  ToDoTutorial
//
//  Created by Charles Suddens on 16/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTask = ""
    @State private var editingIndex : Int?
    var body: some View {
        VStack {
            HStack {
                TextField("Add your task", text: $newTask)
                Button(action: {
                    guard !newTask.isEmpty else { return }
                    if let index = editingIndex {
                        viewModel.updateTask(at: index, task: newTask)
                        editingIndex = nil
                    } else {
                        viewModel.addTask(task: newTask)
                    }

                    newTask = ""
                }) {
                    Text(editingIndex == nil ? "Add" : "Update")
                }
            }
            
            List {
                ForEach(Array(viewModel.tasks.enumerated()), id: \.element) { index, task in
                    HStack {
                        Text(task)
                        Spacer()
                        Button(action: {
                            self.newTask = task
                            self.editingIndex = index
                        }) {
                            Image(systemName: "pencil").foregroundColor(.blue)
                        }
                    }
                }.onDelete(perform: viewModel.deleteTask)
            }
        }.onAppear {
            viewModel.loadTasks()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
