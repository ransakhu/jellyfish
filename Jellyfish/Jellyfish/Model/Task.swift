import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var name: String
    var isCompleted: Bool
    var hasTimer: Bool
    var hasNotification: Bool
    var notificationDate: Date?
    
    init(id: UUID = UUID(), name: String, isCompleted: Bool = false, hasTimer: Bool = false, hasNotification: Bool = false, notificationDate: Date? = nil) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
        self.hasTimer = hasTimer
        self.hasNotification = hasNotification
        self.notificationDate = notificationDate
    }
}
