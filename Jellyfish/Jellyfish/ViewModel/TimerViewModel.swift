//import SwiftUI
//import Combine
//
//// الحالات الثلاثة للشاشة
//enum TimerMode {
//    case selecting   // يختار الوقت
//    case running     // الجيلي فِش شغّالة
//    case finished    // خلص الوقت
//}
//
//final class TimerViewModel: ObservableObject {
//    
//    @Published var mode: TimerMode = .selecting
//    @Published var selectedSeconds: Int = 60      // الوقت اللي يختاره اليوزر
//    @Published var remainingSeconds: Int = 60
//    @Published var isPaused: Bool = false
//    
//    func togglePause() {
//        isPaused.toggle()
//    }
//    // الوقت اللي باقي أثناء التايمر
//    
//    private let model = FocusTimer()
//    private var timer: Timer?
//    
//    var maxSeconds: Int {
//        model.maxSeconds
//    }
//    
//    // نسبة امتلاء الدائرة في شاشة الاختيار
//    var selectionProgress: Double {
//        Double(selectedSeconds) / Double(maxSeconds)
//    }
//    
//    // يحدّث القيمة لما اليوزر يحرّك السلايدر (أو بعدين الـ knob)
//    func updateSelection(seconds: Int) {
//        let clamped = min(max(1, seconds), maxSeconds)
//        selectedSeconds = clamped
//        if mode == .selecting {
//            remainingSeconds = clamped
//        }
//    }
//    
//    // يبدأ التايمر وينتقل لوضع الجيلي فِش
//    func startFocus() {
//        remainingSeconds = selectedSeconds
//        mode = .running
//        
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 1,
//                                     repeats: true) { [weak self] _ in
//            guard let self else { return }
//            
//            if self.remainingSeconds > 0 {
//                self.remainingSeconds -= 1
//            } else {
//                self.stopFocus()
//                self.mode = .finished
//            }
//        }
//    }
//    
//    func stopFocus() {
//        timer?.invalidate()
//        timer = nil
//    }
//    
//    func reset() {
//        stopFocus()
//        mode = .selecting
//        remainingSeconds = selectedSeconds
//    }
//}
//import SwiftUI
//import Combine   // مهم عشان ObservableObject و @Published
//
//enum TimerMode {
//    case selecting     // يختار الوقت
//    case running       // التايمر شغّال
//    case finished      // خلص الوقت
//}
//
//final class TimerViewModel: ObservableObject {
//    
//    // الحالة
//    @Published var mode: TimerMode = .selecting
//    @Published var selectedSeconds: Int = 60      // الوقت اللي يختاره اليوزر
//    @Published var remainingSeconds: Int = 60     // الوقت الباقي أثناء التايمر
//    @Published var isPaused: Bool = false         // هل التايمر موقوف مؤقتًا؟
//    
//    private var timer: Timer?
//    
//    var maxSeconds: Int { 120 }
//    
//    var selectionProgress: Double {
//        Double(selectedSeconds) / Double(maxSeconds)
//    }
//    
//    // يحدّث الوقت من السلايدر (أو بعدين من الـ knob)
//    func updateSelection(seconds: Int) {
//        let clamped = min(max(1, seconds), maxSeconds)
//        selectedSeconds = clamped
//        if mode == .selecting {
//            remainingSeconds = clamped
//        }
//    }
//    
//    // يبدأ التايمر ويفتح شاشة الجيلي فِش
//    func startFocus() {
//        remainingSeconds = selectedSeconds
//        mode = .running
//        isPaused = false
//        
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 1,
//                                     repeats: true) { [weak self] _ in
//            guard let self else { return }
//            
//            // 👈 هنا السحر: لو التايمر متوقف مؤقتًا لا نسوي شيء
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
//    // يوقف التايمر نهائي (يوقف الـ Timer نفسه)
//    func stopTimer() {
//        timer?.invalidate()
//        timer = nil
//    }
//    
//    // يبدّل بين Pause و Resume
//    func togglePause() {
//        isPaused.toggle()
//    }
//    
//    // يرجع للشاشة الأولى
//    func reset() {
//        stopTimer()
//        isPaused = false
//        mode = .selecting
//        remainingSeconds = selectedSeconds
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
    
    // اليوزر يختار بالدقايق
    @Published var selectedMinutes: Int = 1
    
    // التايمر نفسه يعد بالثواني
    @Published var remainingSeconds: Int = 60
    
    @Published var isPaused: Bool = false
    
    private var timer: Timer?
    
    // أعلى شيء = ساعتين (120 دقيقة)
    var maxMinutes: Int { 120 }
    
    // نسبة امتلاء الدائرة في شاشة الاختيار
    var selectionProgress: Double {
        Double(selectedMinutes) / Double(maxMinutes)
    }
    
    // تغيير الوقت من شاشة الاختيار (السلايدر / النوب)
    func updateSelection(minutes: Int) {
        let clamped = min(max(1, minutes), maxMinutes)
        selectedMinutes = clamped
        
        if mode == .selecting {
            remainingSeconds = clamped * 60   // نحوله لثواني
        }
    }
    
    // عرض الوقت كـ mm:ss
    func formattedTime(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return String(format: "%02d:%02d", m, s)
    }
    
    // يبدأ التايمر ويفتح شاشة الجيلي فِش
    func startFocus() {
        remainingSeconds = selectedMinutes * 60
        mode = .running
        isPaused = false
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1,
                                     repeats: true) { [weak self] _ in
            guard let self else { return }
            guard !self.isPaused else { return }
            
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
            } else {
                self.stopTimer()
                self.mode = .finished
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
        remainingSeconds = selectedMinutes * 60
    }
}
