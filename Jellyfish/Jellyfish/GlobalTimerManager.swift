import SwiftUI
import Combine
import UserNotifications
import AVFoundation

class GlobalTimerManager: ObservableObject {
    static let shared = GlobalTimerManager()
    
    @Published var activeTimerTaskId: UUID?
    @Published var timerViewModels: [UUID: TimerViewModel] = [:]
    
    private var audioPlayer: AVAudioPlayer?
    
    private init() {
        requestNotificationPermission()
    }
    
    // طلب إذن الإشعارات
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print("Notification permission error: \(error)")
            }
        }
    }
    
    // بدء تايمر لمهمة معينة
    func startTimer(for taskId: UUID, taskName: String) -> Bool {
        // تحقق: هل يوجد تايمر نشط؟
        if let activeId = activeTimerTaskId, activeId != taskId {
            return false // لا يمكن بدء تايمر جديد
        }
        
        // إنشاء أو استرجاع التايمر
        if timerViewModels[taskId] == nil {
            timerViewModels[taskId] = TimerViewModel()
        }
        
        activeTimerTaskId = taskId
        
        // إعداد callback عند انتهاء التايمر
        timerViewModels[taskId]?.onTimerFinished = { [weak self] in
            self?.handleTimerFinished(taskId: taskId, taskName: taskName)
        }
        
        return true
    }
    
    // إيقاف التايمر
    func stopTimer(for taskId: UUID) {
        timerViewModels[taskId]?.stopTimer()
        timerViewModels.removeValue(forKey: taskId)
        
        if activeTimerTaskId == taskId {
            activeTimerTaskId = nil
        }
        
        // إلغاء أي إشعارات مجدولة
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [taskId.uuidString])
    }
    
    // عند انتهاء التايمر
    private func handleTimerFinished(taskId: UUID, taskName: String) {
        // تشغيل الصوت
        playSound()
        
        // إرسال إشعار
        sendNotification(taskName: taskName)
        
        // تنظيف
        activeTimerTaskId = nil
    }
    
    // تشغيل صوت التنبيه
    private func playSound() {
        // استخدام الصوت الافتراضي للنظام
        AudioServicesPlaySystemSound(1005) // صوت "تنبيه جديد"
        
        // أو يمكنك إضافة ملف صوت خاص:
        // guard let soundURL = Bundle.main.url(forResource: "timer_done", withExtension: "mp3") else { return }
        // do {
        //     audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
        //     audioPlayer?.play()
        // } catch {
        //     print("Error playing sound: \(error)")
        // }
    }
    
    // إرسال إشعار
    private func sendNotification(taskName: String) {
        let content = UNMutableNotificationContent()
        content.title = "Timer Finished! ⏰"
        content.body = "Your timer for '\(taskName)' is complete!"
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil // إرسال فوري
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error: \(error)")
            }
        }
    }
    
    // التحقق من وجود تايمر نشط
    func hasActiveTimer() -> Bool {
        return activeTimerTaskId != nil
    }
    
    // الحصول على التايمر لمهمة معينة
    func getTimer(for taskId: UUID) -> TimerViewModel? {
        return timerViewModels[taskId]
    }
}
