import SwiftUI
import Combine

class TaskListViewModel: ObservableObject {
    @Published var taskLists: [TaskList] = []
    @Published var showingAddList = false
    
    private let saveKey = "SavedTaskLists"
    
    init() {
        loadTaskLists()
    }
    
    func addTaskList(name: String) {
        let newList = TaskList(name: name)
        taskLists.append(newList)
        saveTaskLists()
    }
    
    func deleteTaskList(at offsets: IndexSet) {
        taskLists.remove(atOffsets: offsets)
        saveTaskLists()
    }
    
    func archiveTaskList(_ list: TaskList) {
        if let index = taskLists.firstIndex(where: { $0.id == list.id }) {
            taskLists[index].isArchived = true
            saveTaskLists()
        }
    }
    
    func unarchiveTaskList(_ list: TaskList) {
        if let index = taskLists.firstIndex(where: { $0.id == list.id }) {
            taskLists[index].isArchived = false
            saveTaskLists()
        }
    }
    
    func deleteTaskListById(_ listId: UUID) {
        taskLists.removeAll { $0.id == listId }
        saveTaskLists()
    }
    
    func updateTaskList(_ updatedList: TaskList) {
        if let index = taskLists.firstIndex(where: { $0.id == updatedList.id }) {
            taskLists[index] = updatedList
            saveTaskLists()
        }
    }
    
    var activeLists: [TaskList] {
        taskLists.filter { !$0.isArchived }
    }
    
    var archivedLists: [TaskList] {
        taskLists.filter { $0.isArchived }
    }
    
    private func saveTaskLists() {
        if let encoded = try? JSONEncoder().encode(taskLists) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadTaskLists() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([TaskList].self, from: data) {
            taskLists = decoded
        }
    }
}
