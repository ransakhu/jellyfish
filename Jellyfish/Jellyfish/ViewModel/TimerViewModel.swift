//
//
//
//import SwiftUI
//import Combine
//
//enum TimerMode {
//    case selecting
//    case running
//    case finished
//}
//
//final class TimerViewModel: ObservableObject {
//    
//    @Published var mode: TimerMode = .selecting
//    
//    // اليوزر يختار بالدقايق
//    @Published var selectedMinutes: Int = 1
//    
//    // التايمر نفسه يعد بالثواني
//    @Published var remainingSeconds: Int = 60
//    
//    @Published var isPaused: Bool = false
//    
//    private var timer: Timer?
//    
//    // أعلى شيء = ساعتين (120 دقيقة)
//    var maxMinutes: Int { 120 }
//    
//    // نسبة امتلاء الدائرة في شاشة الاختيار
//    var selectionProgress: Double {
//        Double(selectedMinutes) / Double(maxMinutes)
//    }
//    
//    // تغيير الوقت من شاشة الاختيار (السلايدر / النوب)
//    func updateSelection(minutes: Int) {
//        let clamped = min(max(1, minutes), maxMinutes)
//        selectedMinutes = clamped
//        
//        if mode == .selecting {
//            remainingSeconds = clamped * 60   // نحوله لثواني
//        }
//    }
//    
//    // عرض الوقت كـ mm:ss
//    func formattedTime(_ seconds: Int) -> String {
//        let m = seconds / 60
//        let s = seconds % 60
//        return String(format: "%02d:%02d", m, s)
//    }
//    
//    // يبدأ التايمر ويفتح شاشة الجيلي فِش
//    func startFocus() {
//        remainingSeconds = selectedMinutes * 60
//        mode = .running
//        isPaused = false
//        
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 1,
//                                     repeats: true) { [weak self] _ in
//            guard let self else { return }
//            guard !self.isPaused else { return }
//            
//            if self.remainingSeconds > 0 {
//                self.remainingSeconds -= 1
//            } else {
//                self.stopTimer()
//                self.mode = .finished
//            }
//        }
//    }
//    
//    func togglePause() {
//        isPaused.toggle()
//    }
//    
//    func stopTimer() {
//        timer?.invalidate()
//        timer = nil
//    }
//    
//    func reset() {
//        stopTimer()
//        isPaused = false
//        mode = .selecting
//        remainingSeconds = selectedMinutes * 60
//    }
//}
import SwiftUI
import Combine

enum TimerMode {
    case selecting
    case running
    case finished
}

final class TimerViewModel: ObservableObject {
    
    @Published var mode: TimerMode = .selecting
    @Published var selectedMinutes: Int = 1
    @Published var remainingSeconds: Int = 60
    @Published var isPaused: Bool = false
    @Published var hasStarted: Bool = false // جديد: لتتبع إذا بدأ التايمر
    
    private var timer: Timer?
    var onTimerFinished: (() -> Void)?
    
    var maxMinutes: Int { 120 }
    
    var selectionProgress: Double {
        Double(selectedMinutes) / Double(maxMinutes)
    }
    
    func updateSelection(minutes: Int) {
        let clamped = min(max(1, minutes), maxMinutes)
        selectedMinutes = clamped
        
        if mode == .selecting {
            remainingSeconds = clamped * 60
        }
    }
    
    func formattedTime(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return String(format: "%02d:%02d", m, s)
    }
    
    func startFocus() {
        guard mode == .selecting else { return }
        
        remainingSeconds = selectedMinutes * 60
        mode = .running
        isPaused = false
        hasStarted = true
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            guard !self.isPaused else { return }
            
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
            } else {
                self.mode = .finished
                self.stopTimer()
                self.onTimerFinished?()
            }
        }
    }
    
    func togglePause() {
        isPaused.toggle()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func reset() {
        stopTimer()
        isPaused = false
        mode = .selecting
        hasStarted = false
        remainingSeconds = selectedMinutes * 60
    }
    
    func cancelTimer() {
        stopTimer()
        isPaused = false
        mode = .selecting
        hasStarted = false
        selectedMinutes = 1
        remainingSeconds = 60
    }
}
