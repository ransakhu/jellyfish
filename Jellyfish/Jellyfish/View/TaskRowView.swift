//
//
////MARK: seprated lines
//
//import SwiftUI
//
//struct TaskRowView: View {
//    let task: Task
//    let onComplete: () -> Void
//    let onTimer: () -> Void
//    let onNotification: () -> Void
//    let onDelete: () -> Void
//    
//    @State private var offset: CGFloat = 0
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            ZStack(alignment: .trailing) {
//                // Delete button background (swipe left)
//                if offset < -50 {
//                    Button {
//                        withAnimation(.spring()) {
//                            onDelete()
//                        }
//                    } label: {
//                        Circle()
//                            .fill(Color.red)
//                            .frame(width: 50, height: 50)
//                            .overlay(
//                                Image(systemName: "trash.fill")
//                                    .font(.title3)
//                                    .foregroundColor(.white)
//                            )
//                    }
//                    .padding(.trailing, 8)
//                }
//                
//                // Task row
//                HStack(spacing: 12) {
//                    Button {
//                        withAnimation(.spring(response: 0.3)) {
//                            onComplete()
//                        }
//                    } label: {
//                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
//                            .foregroundColor(task.isCompleted ? Color(red: 0.6, green: 0.9, blue: 0.6) : .gray)
//                            .font(.title2)
//                    }
//                    
//                    Text(task.name)
//                        .strikethrough(task.isCompleted)
//                        .foregroundColor(task.isCompleted ? .gray : .black)
//                    
//                    Spacer()
//                  /*
//                    HStack(spacing: 8) {
//                        // Timer button - أكبر + خلفية لما يكون مفعّل
//                        Button {
//                            onTimer()
//                        } label: {
//                            ZStack {
//                                if task.hasTimer {
//                                    Circle()
//                                        .fill(Color("Timer"))
//                                        .frame(width: 34, height: 34)
//                                }
//                                Image(systemName: "timer")
//                                    .foregroundColor(task.hasTimer ? .white : Color("Timer"))
//                                    .font(.system(size: 16))
//                            }
//                        }
//                        
//                        // Notification button - أكبر + خلفية لما يكون مفعّل
//                        Button {
//                            onNotification()
//                        } label: {
//                            ZStack {
//                                if task.hasNotification {
//                                    Circle()
//                                        .fill(Color(red: 77/255, green: 182/255, blue: 172/255))
//                                        .frame(width: 34, height: 34)
//                                }
//                                Image(systemName: "bell.fill")
//                                    .foregroundColor(task.hasNotification ? .white : Color(red: 77/255, green: 182/255, blue: 172/255))
//                                    .font(.system(size: 16))
//                            }
//                        } */
//                    HStack(spacing: 8) {
//                            // Timer button - ثابت الحجم
//                            Button {
//                                onTimer()
//                            } label: {
//                                Circle()
//                                    .fill(task.hasTimer ? Color("Timer") : .clear) // خلفية بس إذا مفعّل
//                                    .frame(width: 34, height: 34)                  // 👈 نفس المقاس دايمًا
//                                    .overlay(
//                                        Image(systemName: "timer")
//                                            .foregroundColor(task.hasTimer ? .white : Color("Timer"))
//                                            .font(.system(size: 16))
//                                    )
//                            }
//
//                            // Notification button - ثابت الحجم
//                            Button {
//                                onNotification()
//                            } label: {
//                                Circle()
//                                    .fill(task.hasNotification
//                                          ? Color(red: 77/255, green: 182/255, blue: 172/255)
//                                          : .clear)
//                                    .frame(width: 34, height: 34)                  // 👈 نفس المقاس دايمًا
//                                    .overlay(
//                                        Image(systemName: "bell.fill")
//                                            .foregroundColor(
//                                                task.hasNotification
//                                                ? .white
//                                                : Color(red: 77/255, green: 182/255, blue: 172/255)
//                                            )
//                                            .font(.system(size: 16))
//                                    )
//                            }
//                        }.padding(.trailing,  -16)   // 👈 يحرك الزرين لليسار
//
//
//                    }
//                }
//                .padding(.horizontal, 20)
//                .padding(.vertical, 20)
//                .frame(height: 60)
//                .offset(x: offset)
//                .gesture(
//                    DragGesture()
//                        .onChanged { gesture in
//                            let translation = gesture.translation.width
//                            if translation < 0 {
//                                offset = max(translation, -100)
//                            }
//                        }
//                        .onEnded { gesture in
//                            let translation = gesture.translation.width
//                            withAnimation(.spring()) {
//                                // Hard swipe - delete immediately
//                                if translation < -150 {
//                                    onDelete()
//                                }
//                                // Normal swipe - show delete button
//                                else if translation < -60 {
//                                    offset = -100
//                                }
//                                // Not enough swipe - return to normal
//                                else {
//                                    offset = 0
//                                }
//                            }
//                        }
//                )
//            }
//            
//            // Separator line
//            Divider()
//                .background(Color.gray.opacity(0.3))
//                .padding(.leading, 52)
//        }
//    }
//


//MARK: seprated lines

import SwiftUI

struct TaskRowView: View {
    let task: Task
    let onComplete: () -> Void
    let onTimer: () -> Void
    let onNotification: () -> Void
    let onDelete: () -> Void
    
    @State private var offset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .trailing) {
                // Delete button background (swipe left)
                if offset < -50 {
                    Button {
                        withAnimation(.spring()) {
                            onDelete()
                        }
                    } label: {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "trash.fill")
                                    .font(.title3)
                                    .foregroundColor(.white)
                            )
                    }
                    .padding(.trailing, 8)
                }
                
                // Task row
                HStack(spacing: 12) {
                    Button {
                        withAnimation(.spring(response: 0.3)) {
                            onComplete()
                        }
                    } label: {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.isCompleted ? Color(red: 0.6, green: 0.9, blue: 0.6) : .gray)
                            .font(.title2)
                    }
                    
                    Text(task.name)
                        .strikethrough(task.isCompleted)
                        .foregroundColor(task.isCompleted ? .gray : .black)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        // Timer button - ثابت الحجم
                        Button {
                            onTimer()
                        } label: {
                            Circle()
                                .fill(task.hasTimer ? Color("Timer") : .clear)
                                .frame(width: 34, height: 34)
                                .overlay(
                                    Image(systemName: "timer")
                                        .foregroundColor(task.hasTimer ? .white : Color("Timer"))
                                        .font(.system(size: 16))
                                )
                        }

                        // Notification button - ثابت الحجم
                        Button {
                            onNotification()
                        } label: {
                            Circle()
                                .fill(task.hasNotification
                                      ? Color(red: 77/255, green: 182/255, blue: 172/255)
                                      : .clear)
                                .frame(width: 34, height: 34)
                                .overlay(
                                    Image(systemName: "bell.fill")
                                        .foregroundColor(
                                            task.hasNotification
                                            ? .white
                                            : Color(red: 77/255, green: 182/255, blue: 172/255)
                                        )
                                        .font(.system(size: 16))
                                )
                        }
                    }.padding(.trailing, -16)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .frame(height: 60)
                .background(Color("backgroundColor"))  // ← Add background
                .offset(x: offset)
                .gesture(
                    DragGesture(minimumDistance: 20)  // ← Add minimum distance
                        .onChanged { gesture in
                            let translation = gesture.translation.width
                            // Only allow horizontal swipes (not vertical)
                            if abs(translation) > abs(gesture.translation.height) * 2 {
                                if translation < 0 {
                                    offset = max(translation, -100)
                                }
                            }
                        }
                        .onEnded { gesture in
                            let translation = gesture.translation.width
                            // Only process if horizontal swipe
                            if abs(translation) > abs(gesture.translation.height) * 2 {
                                withAnimation(.spring()) {
                                    // Hard swipe - delete immediately
                                    if translation < -150 {
                                        onDelete()
                                    }
                                    // Normal swipe - show delete button
                                    else if translation < -60 {
                                        offset = -100
                                    }
                                    // Not enough swipe - return to normal
                                    else {
                                        offset = 0
                                    }
                                }
                            } else {
                                // Reset if it was a vertical scroll attempt
                                withAnimation(.spring()) {
                                    offset = 0
                                }
                            }
                        }
                )
            }
            
            // Separator line
            Divider()
                .background(Color.gray.opacity(0.3))
                .padding(.leading, 52)
        }
    }
}
