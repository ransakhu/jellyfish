import Foundation

struct TaskList: Identifiable, Codable {
    let id: UUID
    var name: String
    var tasks: [Task]
    var isArchived: Bool
    var createdDate: Date
    
    init(id: UUID = UUID(), name: String, tasks: [Task] = [], isArchived: Bool = false, createdDate: Date = Date()) {
        self.id = id
        self.name = name
        self.tasks = tasks
        self.isArchived = isArchived
        self.createdDate = createdDate
    }
    
    var progress: Double {
        guard !tasks.isEmpty else { return 0 }
        let completedTasks = tasks.filter { $0.isCompleted }.count
        return Double(completedTasks) / Double(tasks.count)
    }
    
    var hasSubTasks: Bool {
        !tasks.isEmpty
    }
}
