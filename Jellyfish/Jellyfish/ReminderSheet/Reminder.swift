//
//  ContentView.swift
//  jellyfish
//
//  Created by Raghad on 12/06/1447 AH.
//

/*

import SwiftUI
import UserNotifications
import AVFoundation

struct Reminder: View {
    @State private var showAddReminder = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Button("Add Task Details ".localized) {
                showAddReminder = true
            }
            .foregroundColor(.white)
            .sheet(isPresented: $showAddReminder) {
                AddReminderModalView()
            }
        }
        .onAppear {
            requestNotificationPermission()
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted".localized)
            } else {
                print("Notification permission denied".localized)
            }
        }
    }
}

// ---------------- AddReminderModalView ----------------
struct AddReminderModalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedHour: Int
    @State private var selectedMinute: Int
    @State private var selectedPeriod: Int // 0 = AM, 1 = PM
    @State private var showRepeatPicker = false
    @State private var showSoundPicker = false
    @State private var repeatCount = 1
    @State private var selectedSound = "None"
    @State private var labelText = ""
    @FocusState private var labelFieldFocused: Bool
    
    let hours = Array(1...12)
    let minutes = Array(0...59)
    let periods = ["AM", "PM"]
    
    // الألوان المستخدمة (ثابتة لكي نستخدمها بنفس القيمة في كل مكان)
    private let backgroundColor = Color(red: 0xF8/255, green: 0xF5/255, blue: 0xEC/255)
    private let liftedBoxColor = Color(red: 0xFF/255, green: 0xFB/255, blue: 0xF7/255)
    
    init() {
        let calendar = Calendar.current
        let now = Date()
        let currentHour = calendar.component(.hour, from: now)
        let currentMinute = calendar.component(.minute, from: now)
        
        if currentHour == 0 {
            _selectedHour = State(initialValue: 11)
            _selectedPeriod = State(initialValue: 0)
        } else if currentHour < 12 {
            _selectedHour = State(initialValue: currentHour - 1)
            _selectedPeriod = State(initialValue: 0)
        } else if currentHour == 12 {
            _selectedHour = State(initialValue: 11)
            _selectedPeriod = State(initialValue: 1)
        } else {
            _selectedHour = State(initialValue: currentHour - 13)
            _selectedPeriod = State(initialValue: 1)
        }
        
        _selectedMinute = State(initialValue: currentMinute)
    }
    
    var displayLabel: String {
        labelText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Reminder" : labelText
    }
    
    var repeatText: String {
        repeatCount == 1 ? "Never".localized : "\(repeatCount) times daily".localized
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HStack { Spacer() }
                        .frame(height: 0)
                    
                    // Time Pickers
                    HStack(spacing: 0) {
                        Picker("Hour".localized, selection: $selectedHour) {
                            ForEach(0..<hours.count, id: \.self) { index in
                                Text("\(hours[index])")
                                    .font(.system(size: 24))
                                    .tag(index)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 90)
                        
                        Picker("Minute".localized, selection: $selectedMinute) {
                            ForEach(minutes, id: \.self) { minute in
                                Text(String(format: "%02d", minute))
                                    .font(.system(size: 24))
                                    .tag(minute)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 90)
                        
                        Picker("Period".localized, selection: $selectedPeriod) {
                            ForEach(0..<periods.count, id: \.self) { index in
                                Text(periods[index].localized)
                                    .font(.system(size: 24))
                                    .tag(index)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 90)
                    }
                    .frame(height: 200)
                    .padding(.top, 10)
                    
                    Spacer().frame(height: 20)
                    
                    // Options box
                    VStack(spacing: 0) {
                        Button(action: {
                            labelFieldFocused = false
                            showRepeatPicker = true
                        }) {
                            optionRow(title: "Repeat".localized, trailing: repeatText)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider().padding(.leading, 16)
                        
                        Button(action: {
                            labelFieldFocused = false
                            showSoundPicker = true
                        }) {
                            optionRow(title: "Sound".localized, trailing: selectedSound)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider().padding(.leading, 16)
                        
                        // Label row
                        HStack {
                            Text("Label".localized)
                                .foregroundColor(.primary)
                            Spacer()
                            TextField("Reminder".localized, text: $labelText)
                                .foregroundColor(labelText.isEmpty ? .gray : .primary)
                                .multilineTextAlignment(.trailing)
                                .focused($labelFieldFocused)
                        }
                        .padding()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            labelFieldFocused = true
                        }
                    }
                    .background(liftedBoxColor)
                    .cornerRadius(28)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color(UIColor.systemGray4), lineWidth: 0.4)
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                    
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                    }
                    .foregroundColor(.black)
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Add Reminder".localized).font(.headline)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        scheduleNotification()
                        dismiss()
                    }) {
                        Image(systemName: "checkmark")
                    }
                    .foregroundColor(Color("CategoryCard"))
                }
            }
            .interactiveDismissDisabled()
            .sheet(isPresented: $showRepeatPicker) {
                RepeatPickerView(repeatCount: $repeatCount, backgroundColor: liftedBoxColor)
            }
            .sheet(isPresented: $showSoundPicker) {
                SoundPickerView(selectedSound: $selectedSound, backgroundColor: liftedBoxColor)
            }
        }
    }
    
    @ViewBuilder
    private func optionRow(title: String, trailing: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            Text(trailing)
                .foregroundColor(.gray)
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
        .padding()
    }
    
    func scheduleNotification() {
        var hour = hours[selectedHour]
        if selectedPeriod == 1 && hour != 12 {
            hour += 12
        } else if selectedPeriod == 0 && hour == 12 {
            hour = 0
        }
        
        let calendar = Calendar.current
        let now = Date()
        
        var components = calendar.dateComponents([.year, .month, .day], from: now)
        components.hour = hour
        components.minute = selectedMinute
        components.second = 0
        
        guard var scheduledDate = calendar.date(from: components) else { return }
        
        if scheduledDate <= now {
            scheduledDate = calendar.date(byAdding: .day, value: 1, to: scheduledDate) ?? scheduledDate
        }
        
        if repeatCount == 1 {
            scheduleDaily(at: scheduledDate)
        } else {
            for i in 0..<repeatCount {
                let hoursToAdd = i * 3
                if let notificationDate = calendar.date(byAdding: .hour, value: hoursToAdd, to: scheduledDate) {
                    scheduleDaily(at: notificationDate)
                }
            }
        }
        
        sendTestNotification()
        
        print("✅ Scheduled \(repeatCount) notification(s) for '\(displayLabel)' every 3 hours with sound: \(selectedSound)")
    }
    
    func scheduleDaily(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = displayLabel
        content.body = "It's time for your reminder".localized
        content.badge = 1
        
        if selectedSound == "Simple Message" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "1 soundeffect.caf"))
        } else if selectedSound == "Pop up" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "2 soundeffect.caf"))
        } else if selectedSound == "Quick alert" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "3 soundeffect.caf"))
        } else if selectedSound == "Bubbles" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "4 soundeffect.caf"))
        } else if selectedSound == "Message" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "5 soundeffect.caf"))
        } else if selectedSound == "None" {
            content.sound = nil
        } else {
            content.sound = .default
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error scheduling notification: \(error.localizedDescription)")
            } else {
                let timeStr = String(format: "%02d:%02d", components.hour ?? 0, components.minute ?? 0)
                print("✅ Notification scheduled at \(timeStr)")
            }
        }
    }
    
    func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = displayLabel
        content.body = "Test notification - Your reminder is set!"
        content.badge = 1
        
        if selectedSound == "Simple Message" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "1 soundeffect.caf"))
        } else if selectedSound == "Pop up" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "2 soundeffect.caf"))
        } else if selectedSound == "Quick alert" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "3 soundeffect.caf"))
        } else if selectedSound == "Bubbles" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "4 soundeffect.caf"))
        } else if selectedSound == "Message" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "5 soundeffect.caf"))
        } else if selectedSound == "None" {
            content.sound = .default
        } else {
            content.sound = .default
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "test-\(UUID().uuidString)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error sending test notification: \(error.localizedDescription)")
            } else {
                print("✅ Test notification will appear in 3 seconds with title: '\(self.displayLabel)'")
            }
        }
    }
}

struct RepeatPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var repeatCount: Int
    @State private var tempRepeatCount: Int
    var backgroundColor: Color
    
    init(repeatCount: Binding<Int>, backgroundColor: Color) {
        self._repeatCount = repeatCount
        self._tempRepeatCount = State(initialValue: repeatCount.wrappedValue)
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.ignoresSafeArea()
                VStack {
                    Picker("Repeat Count".localized, selection: $tempRepeatCount) {
                        Text("Never".localized).tag(1)
                        ForEach(2...8, id: \.self) { count in
                            Text("\(count) times daily".localized).tag(count)
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding()
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel".localized) { dismiss() }
                        .foregroundColor(.black)
                }
                ToolbarItem(placement: .principal) {
                    Text("Repeat".localized).font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done".localized) {
                        repeatCount = tempRepeatCount
                        dismiss()
                    }
                    .foregroundColor(Color("CategoryCard"))
                }
            }
        }
        .presentationDetents([.medium])
    }
}

struct SoundPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedSound: String
    @State private var tempSelectedSound: String
    @State private var audioPlayer: AVAudioPlayer?
    let sounds = ["Simple Message", "Pop up", "Quick alert", "Bubbles", "Message", "None"]
    var backgroundColor: Color
    
    init(selectedSound: Binding<String>, backgroundColor: Color) {
        self._selectedSound = selectedSound
        self._tempSelectedSound = State(initialValue: selectedSound.wrappedValue)
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.ignoresSafeArea()
                List {
                    ForEach(sounds, id: \.self) { sound in
                        Button(action: {
                            tempSelectedSound = sound
                            playSound(sound)
                        }) {
                            HStack {
                                Text(sound.localized)
                                    .foregroundColor(tempSelectedSound == sound ? Color("CategoryCard") : .black)
                                Spacer()
                                if tempSelectedSound == sound {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color("CategoryCard"))
                                }
                            }
                        }
                        .listRowBackground(backgroundColor)
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }
            .navigationBarTitle("Sound".localized, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel".localized) { dismiss() }
                        .foregroundColor(.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done".localized) {
                        selectedSound = tempSelectedSound
                        dismiss()
                    }
                    .foregroundColor(Color("CategoryCard"))
                }
            }
        }
        .presentationDetents([.medium])
    }
    
    func playSound(_ soundName: String) {
        if soundName == "None" { return }
        
        var fileName = ""
        if soundName == "Simple Message" {
            fileName = "1 soundeffect"
        } else if soundName == "Pop up" {
            fileName = "2 soundeffect"
        } else if soundName == "Quick alert" {
            fileName = "3 soundeffect"
        } else if soundName == "Bubbles" {
            fileName = "4 soundeffect"
        } else if soundName == "Message" {
            fileName = "5 soundeffect"
        }
        
        if let soundURL = Bundle.main.url(forResource: fileName, withExtension: "caf") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
raghads ver
import SwiftUI
import UserNotifications
import AVFoundation

struct Reminder: View {
    @State private var showAddReminder = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Button("Add Task Details".localized) {
                showAddReminder = true
            }
            .foregroundColor(.white)
            .sheet(isPresented: $showAddReminder) {
                AddReminderModalView()
            }
        }
        .onAppear {
            requestNotificationPermission()
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted".localized)
            } else {
                print("Notification permission denied".localized)
            }
        }
    }
}

// ---------------- AddReminderModalView ----------------
struct AddReminderModalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedHour: Int
    @State private var selectedMinute: Int
    @State private var selectedPeriod: Int // 0 = AM, 1 = PM
    @State private var showRepeatPicker = false
    @State private var showSoundPicker = false
    @State private var repeatCount = 1
    @State private var selectedSound = "None"
    @State private var labelText = ""
    @FocusState private var labelFieldFocused: Bool
    
    let hours = Array(1...12)
    let minutes = Array(0...59)
    let periods = ["AM".localized, "PM".localized]
    
    // الألوان المستخدمة (ثابتة لكي نستخدمها بنفس القيمة في كل مكان)
    private let backgroundColor = Color(red: 0xF8/255, green: 0xF5/255, blue: 0xEC/255)
    private let liftedBoxColor = Color(red: 0xFF/255, green: 0xFB/255, blue: 0xF7/255)
    
    init() {
        let calendar = Calendar.current
        let now = Date()
        let currentHour = calendar.component(.hour, from: now)
        let currentMinute = calendar.component(.minute, from: now)
        
        if currentHour == 0 {
            _selectedHour = State(initialValue: 11)
            _selectedPeriod = State(initialValue: 0)
        } else if currentHour < 12 {
            _selectedHour = State(initialValue: currentHour - 1)
            _selectedPeriod = State(initialValue: 0)
        } else if currentHour == 12 {
            _selectedHour = State(initialValue: 11)
            _selectedPeriod = State(initialValue: 1)
        } else {
            _selectedHour = State(initialValue: currentHour - 13)
            _selectedPeriod = State(initialValue: 1)
        }
        
        _selectedMinute = State(initialValue: currentMinute)
    }
    
    var displayLabel: String {
        labelText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Reminder".localized : labelText
    }
    
    var repeatText: String {
        if repeatCount == 1 {
            return "Never".localized
        } else {
            let localizedCount = formatNumber(repeatCount)
            return String(format: "%@ times daily".localized, localizedCount)
        }
    }
    
    // Function to convert numbers to localized format
    func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HStack { Spacer() }
                        .frame(height: 0)
                    
                    // Time Pickers
                    HStack(spacing: 0) {
                        Picker("Hour", selection: $selectedHour) {
                            ForEach(0..<hours.count, id: \.self) { index in
                                Text(formatNumber(hours[index]))
                                    .font(.system(size: 24))
                                    .tag(index)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 90)
                        
                        Picker("Minute", selection: $selectedMinute) {
                            ForEach(minutes, id: \.self) { minute in
                                Text(String(format: "%02d", minute).applyingTransform(StringTransform("Any-Latin; Latin-Arabic"), reverse: false) ?? String(format: "%02d", minute))
                                    .font(.system(size: 24))
                                    .tag(minute)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 90)
                        
                        Picker("Period", selection: $selectedPeriod) {
                            ForEach(0..<periods.count, id: \.self) { index in
                                Text(periods[index])
                                    .font(.system(size: 24))
                                    .tag(index)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 90)
                    }
                    .frame(height: 200)
                    .padding(.top, 10)
                    
                    Spacer().frame(height: 20)
                    
                    // Options box
                    VStack(spacing: 0) {
                        Button(action: {
                            labelFieldFocused = false
                            showRepeatPicker = true
                        }) {
                            optionRow(title: "Repeat".localized, trailing: repeatText)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider().padding(.leading, 16)
                        
                        Button(action: {
                            labelFieldFocused = false
                            showSoundPicker = true
                        }) {
                            optionRow(title: "Sound".localized, trailing: selectedSound.localized)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider().padding(.leading, 16)
                        
                        // Label row
                        HStack {
                            Text("Label".localized)
                                .foregroundColor(.primary)
                            Spacer()
                            TextField("Reminder".localized, text: $labelText)
                                .foregroundColor(labelText.isEmpty ? .gray : .primary)
                                .multilineTextAlignment(.trailing)
                                .focused($labelFieldFocused)
                        }
                        .padding()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            labelFieldFocused = true
                        }
                    }
                    .background(liftedBoxColor)
                    .cornerRadius(28)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color(UIColor.systemGray4), lineWidth: 0.4)
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                    
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                    }
                    .foregroundColor(.black)
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Add Reminder".localized).font(.headline)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        scheduleNotification()
                        dismiss()
                    }) {
                        Image(systemName: "checkmark")
                    }
                    .foregroundColor(Color("CategoryCard"))
                }
            }
            .interactiveDismissDisabled()
            .sheet(isPresented: $showRepeatPicker) {
                RepeatPickerView(repeatCount: $repeatCount, backgroundColor: liftedBoxColor)
            }
            .sheet(isPresented: $showSoundPicker) {
                SoundPickerView(selectedSound: $selectedSound, backgroundColor: liftedBoxColor)
            }
        }
    }
    
    @ViewBuilder
    private func optionRow(title: String, trailing: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            Text(trailing)
                .foregroundColor(.gray)
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
        .padding()
    }
    
    func scheduleNotification() {
        var hour = hours[selectedHour]
        if selectedPeriod == 1 && hour != 12 {
            hour += 12
        } else if selectedPeriod == 0 && hour == 12 {
            hour = 0
        }
        
        let calendar = Calendar.current
        let now = Date()
        
        var components = calendar.dateComponents([.year, .month, .day], from: now)
        components.hour = hour
        components.minute = selectedMinute
        components.second = 0
        
        guard var scheduledDate = calendar.date(from: components) else { return }
        
        if scheduledDate <= now {
            scheduledDate = calendar.date(byAdding: .day, value: 1, to: scheduledDate) ?? scheduledDate
        }
        
        if repeatCount == 1 {
            scheduleDaily(at: scheduledDate)
        } else {
            for i in 0..<repeatCount {
                let hoursToAdd = i * 3
                if let notificationDate = calendar.date(byAdding: .hour, value: hoursToAdd, to: scheduledDate) {
                    scheduleDaily(at: notificationDate)
                }
            }
        }
        
        sendTestNotification()
        
        print("✅ Scheduled \(repeatCount) notification(s) for '\(displayLabel)' every 3 hours with sound: \(selectedSound)")
    }
    
    func scheduleDaily(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = displayLabel
        content.body = "It's time for your reminder".localized
        content.badge = 1
        
        if selectedSound == "Simple Message" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "1 soundeffect.caf"))
        } else if selectedSound == "Pop up" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "2 soundeffect.caf"))
        } else if selectedSound == "Quick alert" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "3 soundeffect.caf"))
        } else if selectedSound == "Bubbles" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "4 soundeffect.caf"))
        } else if selectedSound == "Message" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "5 soundeffect.caf"))
        } else if selectedSound == "None" {
            content.sound = nil
        } else {
            content.sound = .default
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error scheduling notification: \(error.localizedDescription)")
            } else {
                let timeStr = String(format: "%02d:%02d", components.hour ?? 0, components.minute ?? 0)
                print("✅ Notification scheduled at \(timeStr)")
            }
        }
    }
    
    func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = displayLabel
        content.body = "Test notification - Your reminder is set!".localized
        content.badge = 1
        
        if selectedSound == "Simple Message" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "1 soundeffect.caf"))
        } else if selectedSound == "Pop up" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "2 soundeffect.caf"))
        } else if selectedSound == "Quick alert" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "3 soundeffect.caf"))
        } else if selectedSound == "Bubbles" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "4 soundeffect.caf"))
        } else if selectedSound == "Message" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "5 soundeffect.caf"))
        } else if selectedSound == "None" {
            content.sound = .default
        } else {
            content.sound = .default
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "test-\(UUID().uuidString)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error sending test notification: \(error.localizedDescription)")
            } else {
                print("✅ Test notification will appear in 3 seconds with title: '\(self.displayLabel)'")
            }
        }
    }
}

struct RepeatPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var repeatCount: Int
    @State private var tempRepeatCount: Int
    var backgroundColor: Color
    
    init(repeatCount: Binding<Int>, backgroundColor: Color) {
        self._repeatCount = repeatCount
        self._tempRepeatCount = State(initialValue: repeatCount.wrappedValue)
        self.backgroundColor = backgroundColor
    }
    
    func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.ignoresSafeArea()
                VStack {
                    Picker("Repeat Count".localized, selection: $tempRepeatCount) {
                        Text("Never".localized).tag(1)
                        ForEach(2...8, id: \.self) { count in
                            let localizedCount = formatNumber(count)
                            Text(String(format: "times daily".localized, localizedCount)).tag(count)
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding()
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel".localized) { dismiss() }
                        .foregroundColor(.black)
                }
                ToolbarItem(placement: .principal) {
                    Text("Repeat".localized).font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done".localized) {
                        repeatCount = tempRepeatCount
                        dismiss()
                    }
                    .foregroundColor(Color("CategoryCard"))
                }
            }
        }
        .presentationDetents([.medium])
    }
}

struct SoundPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedSound: String
    @State private var tempSelectedSound: String
    @State private var audioPlayer: AVAudioPlayer?
    let sounds = ["Simple Message", "Pop up", "Quick alert", "Bubbles", "Message", "None"]
    var backgroundColor: Color
    
    init(selectedSound: Binding<String>, backgroundColor: Color) {
        self._selectedSound = selectedSound
        self._tempSelectedSound = State(initialValue: selectedSound.wrappedValue)
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.ignoresSafeArea()
                List {
                    ForEach(sounds, id: \.self) { sound in
                        Button(action: {
                            tempSelectedSound = sound
                            playSound(sound)
                        }) {
                            HStack {
                                Text(sound.localized)
                                    .foregroundColor(tempSelectedSound == sound ? Color("CategoryCard") : .black)
                                Spacer()
                                if tempSelectedSound == sound {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color("CategoryCard"))
                                }
                            }
                        }
                        .listRowBackground(backgroundColor)
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }
            .navigationBarTitle("Sound".localized, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel".localized) { dismiss() }
                        .foregroundColor(.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done".localized) {
                        selectedSound = tempSelectedSound
                        dismiss()
                    }
                    .foregroundColor(Color("CategoryCard"))
                }
            }
        }
        .presentationDetents([.medium])
    }
    
    func playSound(_ soundName: String) {
        if soundName == "None" { return }
        
        var fileName = ""
        if soundName == "Simple Message" {
            fileName = "1 soundeffect"
        } else if soundName == "Pop up" {
            fileName = "2 soundeffect"
        } else if soundName == "Quick alert" {
            fileName = "3 soundeffect"
        } else if soundName == "Bubbles" {
            fileName = "4 soundeffect"
        } else if soundName == "Message" {
            fileName = "5 soundeffect"
        }
        
        if let soundURL = Bundle.main.url(forResource: fileName, withExtension: "caf") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} */
import SwiftUI
import UserNotifications
import AVFoundation

struct Reminder: View {
    @State private var showAddReminder = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Button("Add Task Details".localized) {
                showAddReminder = true
            }
            .foregroundColor(.white)
            .sheet(isPresented: $showAddReminder) {
                AddReminderModalView()
            }
        }
        .onAppear {
            requestNotificationPermission()
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted".localized)
            } else {
                print("Notification permission denied".localized)
            }
        }
    }
}

// ---------------- AddReminderModalView ----------------
struct AddReminderModalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedHour: Int
    @State private var selectedMinute: Int
    @State private var selectedPeriod: Int // 0 = AM, 1 = PM
    @State private var showRepeatPicker = false
    @State private var showSoundPicker = false
    @State private var repeatCount = 1
    @State private var selectedSound = "None"
    @State private var labelText = ""
    @FocusState private var labelFieldFocused: Bool
    
    let hours = Array(1...12)
    let minutes = Array(0...59)
    let periods = ["AM".localized, "PM".localized]
    
    // الألوان المستخدمة (ثابتة لكي نستخدمها بنفس القيمة في كل مكان)
    private let backgroundColor = Color(red: 0xF8/255, green: 0xF5/255, blue: 0xEC/255)
    private let liftedBoxColor = Color(red: 0xFF/255, green: 0xFB/255, blue: 0xF7/255)
    
    init() {
        let calendar = Calendar.current
        let now = Date()
        let currentHour = calendar.component(.hour, from: now)
        let currentMinute = calendar.component(.minute, from: now)
        
        if currentHour == 0 {
            _selectedHour = State(initialValue: 11)
            _selectedPeriod = State(initialValue: 0)
        } else if currentHour < 12 {
            _selectedHour = State(initialValue: currentHour - 1)
            _selectedPeriod = State(initialValue: 0)
        } else if currentHour == 12 {
            _selectedHour = State(initialValue: 11)
            _selectedPeriod = State(initialValue: 1)
        } else {
            _selectedHour = State(initialValue: currentHour - 13)
            _selectedPeriod = State(initialValue: 1)
        }
        
        _selectedMinute = State(initialValue: currentMinute)
    }
    
    var displayLabel: String {
        labelText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Reminder".localized : labelText
    }
    
    // النص اللي يظهر تحت "Repeat"
    var repeatText: String {
        if repeatCount == 1 {
            return "Never".localized
        } else {
            let localizedCount = formatNumber(repeatCount)
            
            // نستخدم RTL Embedding عشان نثبت الاتجاه: رقم ثم نص
            let rtlEmbed = "\u{202B}" // Right-to-Left Embedding
            let popDir  = "\u{202C}"  // Pop Directional Formatting
            
            let core = "\(localizedCount) \("times daily".localized)"
            return "\(rtlEmbed)\(core)\(popDir)"
        }
    }
    
    // Function to convert numbers to localized format
    func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HStack { Spacer() }
                        .frame(height: 0)
                    
                    // Time Pickers
                    HStack(spacing: 0) {
                        Picker("Hour", selection: $selectedHour) {
                            ForEach(0..<hours.count, id: \.self) { index in
                                Text(formatNumber(hours[index]))
                                    .font(.system(size: 24))
                                    .tag(index)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 90)
                        
                        Picker("Minute", selection: $selectedMinute) {
                            ForEach(minutes, id: \.self) { minute in
                                Text(String(format: "%02d", minute).applyingTransform(StringTransform("Any-Latin; Latin-Arabic"), reverse: false) ?? String(format: "%02d", minute))
                                    .font(.system(size: 24))
                                    .tag(minute)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 90)
                        
                        Picker("Period", selection: $selectedPeriod) {
                            ForEach(0..<periods.count, id: \.self) { index in
                                Text(periods[index])
                                    .font(.system(size: 24))
                                    .tag(index)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 90)
                    }
                    .frame(height: 200)
                    .padding(.top, 10)
                    
                    Spacer().frame(height: 20)
                    
                    // Options box
                    VStack(spacing: 0) {
                        Button(action: {
                            labelFieldFocused = false
                            showRepeatPicker = true
                        }) {
                            optionRow(title: "Repeat".localized, trailing: repeatText)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider().padding(.leading, 16)
                        
                        Button(action: {
                            labelFieldFocused = false
                            showSoundPicker = true
                        }) {
                            optionRow(title: "Sound".localized, trailing: selectedSound.localized)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider().padding(.leading, 16)
                        
                        // Label row
                        HStack {
                            Text("Label".localized)
                                .foregroundColor(.primary)
                            Spacer()
                            TextField("Reminder".localized, text: $labelText)
                                .foregroundColor(labelText.isEmpty ? .gray : .primary)
                                .multilineTextAlignment(.trailing)
                                .focused($labelFieldFocused)
                        }
                        .padding()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            labelFieldFocused = true
                        }
                    }
                    .background(liftedBoxColor)
                    .cornerRadius(28)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color(UIColor.systemGray4), lineWidth: 0.4)
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                    
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                    }
                    .foregroundColor(.black)
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Add Reminder".localized).font(.headline)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        scheduleNotification()
                        dismiss()
                    }) {
                        Image(systemName: "checkmark")
                    }
                    .foregroundColor(Color("CategoryCard"))
                }
            }
            .interactiveDismissDisabled()
            .sheet(isPresented: $showRepeatPicker) {
                RepeatPickerView(repeatCount: $repeatCount, backgroundColor: liftedBoxColor)
            }
            .sheet(isPresented: $showSoundPicker) {
                SoundPickerView(selectedSound: $selectedSound, backgroundColor: liftedBoxColor)
            }
        }
    }
    
    @ViewBuilder
    private func optionRow(title: String, trailing: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            Text(trailing)
                .foregroundColor(.gray)
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
        .padding()
    }
    
    func scheduleNotification() {
        var hour = hours[selectedHour]
        if selectedPeriod == 1 && hour != 12 {
            hour += 12
        } else if selectedPeriod == 0 && hour == 12 {
            hour = 0
        }
        
        let calendar = Calendar.current
        let now = Date()
        
        var components = calendar.dateComponents([.year, .month, .day], from: now)
        components.hour = hour
        components.minute = selectedMinute
        components.second = 0
        
        guard var scheduledDate = calendar.date(from: components) else { return }
        
        if scheduledDate <= now {
            scheduledDate = calendar.date(byAdding: .day, value: 1, to: scheduledDate) ?? scheduledDate
        }
        
        if repeatCount == 1 {
            scheduleDaily(at: scheduledDate)
        } else {
            for i in 0..<repeatCount {
                let hoursToAdd = i * 3
                if let notificationDate = calendar.date(byAdding: .hour, value: hoursToAdd, to: scheduledDate) {
                    scheduleDaily(at: notificationDate)
                }
            }
        }
        
        sendTestNotification()
        
        print("✅ Scheduled \(repeatCount) notification(s) for '\(displayLabel)' every 3 hours with sound: \(selectedSound)")
    }
    
    func scheduleDaily(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = displayLabel
        content.body = "It's time for your reminder".localized
        content.badge = 1
        
        if selectedSound == "Simple Message" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "1 soundeffect.caf"))
        } else if selectedSound == "Pop up" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "2 soundeffect.caf"))
        } else if selectedSound == "Quick alert" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "3 soundeffect.caf"))
        } else if selectedSound == "Bubbles" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "4 soundeffect.caf"))
        } else if selectedSound == "Message" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "5 soundeffect.caf"))
        } else if selectedSound == "None" {
            content.sound = nil
        } else {
            content.sound = .default
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error scheduling notification: \(error.localizedDescription)")
            } else {
                let timeStr = String(format: "%02d:%02d", components.hour ?? 0, components.minute ?? 0)
                print("✅ Notification scheduled at \(timeStr)")
            }
        }
    }
    
    func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = displayLabel
        content.body = "Test notification - Your reminder is set!".localized
        content.badge = 1
        
        if selectedSound == "Simple Message" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "1 soundeffect.caf"))
        } else if selectedSound == "Pop up" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "2 soundeffect.caf"))
        } else if selectedSound == "Quick alert" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "3 soundeffect.caf"))
        } else if selectedSound == "Bubbles" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "4 soundeffect.caf"))
        } else if selectedSound == "Message" {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "5 soundeffect.caf"))
        } else if selectedSound == "None" {
            content.sound = .default
        } else {
            content.sound = .default
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "test-\(UUID().uuidString)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error sending test notification: \(error.localizedDescription)")
            } else {
                print("✅ Test notification will appear in 3 seconds with title: '\(self.displayLabel)'")
            }
        }
    }
}

struct RepeatPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var repeatCount: Int
    @State private var tempRepeatCount: Int
    var backgroundColor: Color
    
    init(repeatCount: Binding<Int>, backgroundColor: Color) {
        self._repeatCount = repeatCount
        self._tempRepeatCount = State(initialValue: repeatCount.wrappedValue)
        self.backgroundColor = backgroundColor
    }
    
    func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.ignoresSafeArea()
                VStack {
                    Picker("Repeat Count".localized, selection: $tempRepeatCount) {
                        Text("Never".localized).tag(1)
                        ForEach(2...8, id: \.self) { count in
                            let localizedCount = formatNumber(count)
                            
                            let rtlEmbed = "\u{202B}" // Right-to-Left Embedding
                            let popDir  = "\u{202C}"  // Pop Directional Formatting
                            
                            let core = "\(localizedCount) \("times daily".localized)"
                            Text("\(rtlEmbed)\(core)\(popDir)")
                                .tag(count)
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding()
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel".localized) { dismiss() }
                        .foregroundColor(.black)
                }
                ToolbarItem(placement: .principal) {
                    Text("Repeat".localized).font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done".localized) {
                        repeatCount = tempRepeatCount
                        dismiss()
                    }
                    .foregroundColor(Color("CategoryCard"))
                }
            }
        }
        .presentationDetents([.medium])
    }
}

struct SoundPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedSound: String
    @State private var tempSelectedSound: String
    @State private var audioPlayer: AVAudioPlayer?
    let sounds = ["Simple Message", "Pop up", "Quick alert", "Bubbles", "Message", "None"]
    var backgroundColor: Color
    
    init(selectedSound: Binding<String>, backgroundColor: Color) {
        self._selectedSound = selectedSound
        self._tempSelectedSound = State(initialValue: selectedSound.wrappedValue)
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.ignoresSafeArea()
                List {
                    ForEach(sounds, id: \.self) { sound in
                        Button(action: {
                            tempSelectedSound = sound
                            playSound(sound)
                        }) {
                            HStack {
                                Text(sound.localized)
                                    .foregroundColor(tempSelectedSound == sound ? Color("CategoryCard") : .black)
                                Spacer()
                                if tempSelectedSound == sound {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color("CategoryCard"))
                                }
                            }
                        }
                        .listRowBackground(backgroundColor)
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }
            .navigationBarTitle("Sound".localized, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel".localized) { dismiss() }
                        .foregroundColor(.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done".localized) {
                        selectedSound = tempSelectedSound
                        dismiss()
                    }
                    .foregroundColor(Color("CategoryCard"))
                }
            }
        }
        .presentationDetents([.medium])
    }
    
    func playSound(_ soundName: String) {
        if soundName == "None" { return }
        
        var fileName = ""
        if soundName == "Simple Message" {
            fileName = "1 soundeffect"
        } else if soundName == "Pop up" {
            fileName = "2 soundeffect"
        } else if soundName == "Quick alert" {
            fileName = "3 soundeffect"
        } else if soundName == "Bubbles" {
            fileName = "4 soundeffect"
        } else if soundName == "Message" {
            fileName = "5 soundeffect"
        }
        
        if let soundURL = Bundle.main.url(forResource: fileName, withExtension: "caf") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
