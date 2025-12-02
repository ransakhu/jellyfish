import SwiftUI
import Combine

class TaskDetailViewModel: ObservableObject {
    @Published var taskList: TaskList
    @Published var showingAddTask = false
    private let parentViewModel: TaskListViewModel
    
    init(taskList: TaskList, parentViewModel: TaskListViewModel) {
        self.taskList = taskList
        self.parentViewModel = parentViewModel
    }
    
    func addTask(name: String) {
        let newTask = Task(name: name)
        taskList.tasks.append(newTask)
        updateParent()
    }
    
    func toggleTaskCompletion(_ task: Task) {
        if let index = taskList.tasks.firstIndex(where: { $0.id == task.id }) {
            taskList.tasks[index].isCompleted.toggle()
            updateParent()
        }
    }
    
    func enableTimer(for task: Task) {
        if let index = taskList.tasks.firstIndex(where: { $0.id == task.id }) {
            taskList.tasks[index].hasTimer = true
            updateParent()
        }
    }
    
    func enableNotification(for task: Task, date: Date) {
        if let index = taskList.tasks.firstIndex(where: { $0.id == task.id }) {
            taskList.tasks[index].hasNotification = true
            taskList.tasks[index].notificationDate = date
            updateParent()
        }
    }
    
    func deleteTask(_ task: Task) {
        taskList.tasks.removeAll { $0.id == task.id }
        updateParent()
    }
    
    private func updateParent() {
        parentViewModel.updateTaskList(taskList)
    }
}
