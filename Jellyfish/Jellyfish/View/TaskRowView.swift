//import SwiftUI
//
//struct TaskRowView: View {
//    let task: Task
//    let onComplete: () -> Void
//    let onTimer: () -> Void
//    let onNotification: () -> Void
//    
//    @State private var offset: CGFloat = 0
//    
//    var body: some View {
//        ZStack(alignment: .trailing) {
//            // Background options (timer + notification) - circles without rounded backgrounds
//            if offset < -50 {
//                HStack(spacing: 12) {
//                    Button {
//                        withAnimation(.spring()) {
//                            onTimer()
//                            offset = 0
//                        }
//                    } label: {
//                        Circle()
//                            .fill(Color.orange)
//                            .frame(width: 60, height: 60)
//                            .overlay(
//                                Image(systemName: "timer")
//                                    .font(.title2)
//                                    .foregroundColor(.white)
//                            )
//                    }
//                    
//                    Button {
//                        withAnimation(.spring()) {
//                            onNotification()
//                            offset = 0
//                        }
//                    } label: {
//                        Circle()
//                            .fill(Color.purple)
//                            .frame(width: 60, height: 60)
//                            .overlay(
//                                Image(systemName: "bell.fill")
//                                    .font(.title2)
//                                    .foregroundColor(.white)
//                            )
//                    }
//                }
//                .padding(.trailing, 8)
//            }
//            
//            // Task row
//            HStack(spacing: 12) {
//                Button {
//                    withAnimation(.spring(response: 0.3)) {
//                        onComplete()
//                    }
//                } label: {
//                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
//                        .foregroundColor(task.isCompleted ? .green : .gray)
//                        .font(.title2)
//                }
//                
//                Text(task.name)
//                    .strikethrough(task.isCompleted)
//                    .foregroundColor(task.isCompleted ? .gray : .primary)
//                
//                Spacer()
//                
//                HStack(spacing: 8) {
//                    if task.hasTimer {
//                        Image(systemName: "timer")
//                            .foregroundColor(.orange)
//                            .font(.caption)
//                    }
//                    if task.hasNotification {
//                        Image(systemName: "bell.fill")
//                            .foregroundColor(.purple)
//                            .font(.caption)
//                    }
//                }
//            }
//            .padding()
//            .background(Color(.systemGray6))
//            .cornerRadius(25)
//            .offset(x: offset)
//            .gesture(
//                DragGesture()
//                    .onChanged { gesture in
//                        let translation = gesture.translation.width
//                        if translation < 0 {
//                            offset = max(translation, -144)
//                        }
//                    }
//                    .onEnded { gesture in
//                        withAnimation(.spring()) {
//                            if gesture.translation.width < -80 {
//                                offset = -144
//                            } else {
//                                offset = 0
//                            }
//                        }
//                    }
//            )
//        }
//    }
//}








//v23
//import SwiftUI
//
//struct TaskRowView: View {
//    let task: Task
//    let onComplete: () -> Void
//    let onTimer: () -> Void
//    let onNotification: () -> Void
//    
//    @State private var offset: CGFloat = 0
//    
//    var body: some View {
//        ZStack(alignment: .trailing) {
//            // Background options (timer + notification) - circles without rounded backgrounds
//            if offset < -50 {
//                HStack(spacing: 12) {
//                    Button {
//                        withAnimation(.spring()) {
//                            onTimer()
//                            offset = 0
//                        }
//                    } label: {
//                        Circle()
//                            .fill(Color.orange)
//                            .frame(width: 60, height: 60)
//                            .overlay(
//                                Image(systemName: "timer")
//                                    .font(.title2)
//                                    .foregroundColor(.white)
//                            )
//                    }
//                    
//                    Button {
//                        withAnimation(.spring()) {
//                            onNotification()
//                            offset = 0
//                        }
//                    } label: {
//                        Circle()
//                            .fill(Color.purple)
//                            .frame(width: 60, height: 60)
//                            .overlay(
//                                Image(systemName: "bell.fill")
//                                    .font(.title2)
//                                    .foregroundColor(.white)
//                            )
//                    }
//                }
//                .padding(.trailing, 8)
//            }
//            
//            // Task row
//            HStack(spacing: 12) {
//                Button {
//                    withAnimation(.spring(response: 0.3)) {
//                        onComplete()
//                    }
//                } label: {
//                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
//                        .foregroundColor(task.isCompleted ? .green : .gray)
//                        .font(.title2)
//                }
//                
//                Text(task.name)
//                    .strikethrough(task.isCompleted)
//                    .foregroundColor(task.isCompleted ? .gray : .primary)
//                
//                Spacer()
//                
//                HStack(spacing: 8) {
//                    if task.hasTimer {
//                        Image(systemName: "timer")
//                            .foregroundColor(.orange)
//                            .font(.caption)
//                    }
//                    if task.hasNotification {
//                        Image(systemName: "bell.fill")
//                            .foregroundColor(.purple)
//                            .font(.caption)
//                    }
//                }
//            }
//            .padding()
//            .background(Color("TaskColor"))
//            .cornerRadius(25)
//            .offset(x: offset)
//            .gesture(
//                DragGesture()
//                    .onChanged { gesture in
//                        let translation = gesture.translation.width
//                        if translation < 0 {
//                            offset = max(translation, -144)
//                        }
//                    }
//                    .onEnded { gesture in
//                        withAnimation(.spring()) {
//                            if gesture.translation.width < -80 {
//                                offset = -144
//                            } else {
//                                offset = 0
//                            }
//                        }
//                    }
//            )
//        }
//    }
//}




//MARK: v24
//import SwiftUI
//
//struct TaskRowView: View {
//    let task: Task
//    let onComplete: () -> Void
//    let onTimer: () -> Void
//    let onNotification: () -> Void
//    
//    @State private var offset: CGFloat = 0
//    
//    var body: some View {
//        ZStack(alignment: .trailing) {
//            // Background options (timer + notification) - circles without rounded backgrounds
//            if offset < -50 {
//                HStack(spacing: 12) {
//                    Button {
//                        withAnimation(.spring()) {
//                            onTimer()
//                            offset = 0
//                        }
//                    } label: {
//                        Circle()
//                            .fill(Color.orange)
//                            .frame(width: 60, height: 60)
//                            .overlay(
//                                Image(systemName: "timer")
//                                    .font(.title2)
//                                    .foregroundColor(.white)
//                            )
//                    }
//                    
//                    Button {
//                        withAnimation(.spring()) {
//                            onNotification()
//                            offset = 0
//                        }
//                    } label: {
//                        Circle()
//                            .fill(Color.purple)
//                            .frame(width: 60, height: 60)
//                            .overlay(
//                                Image(systemName: "bell.fill")
//                                    .font(.title2)
//                                    .foregroundColor(.white)
//                            )
//                    }
//                }
//                .padding(.trailing, 8)
//            }
//            
//            // Task row
//            HStack(spacing: 12) {
//                Button {
//                    withAnimation(.spring(response: 0.3)) {
//                        onComplete()
//                    }
//                } label: {
//                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
//                        .foregroundColor(task.isCompleted ? .green : .gray)
//                        .font(.title2)
//                }
//                
//                Text(task.name)
//                    .strikethrough(task.isCompleted)
//                    .foregroundColor(task.isCompleted ? .gray : .primary)
//                
//                Spacer()
//                
//                HStack(spacing: 8) {
//                    if task.hasTimer {
//                        Image(systemName: "timer")
//                            .foregroundColor(.orange)
//                            .font(.caption)
//                    }
//                    if task.hasNotification {
//                        Image(systemName: "bell.fill")
//                            .foregroundColor(.purple)
//                            .font(.caption)
//                    }
//                }
//            }
//            .padding()
//            .background(Color("TaskColor"))
//            .cornerRadius(25)
//            .offset(x: offset)
//            .gesture(
//                DragGesture()
//                    .onChanged { gesture in
//                        let translation = gesture.translation.width
//                        if translation < 0 {
//                            offset = max(translation, -144)
//                        }
//                    }
//                    .onEnded { gesture in
//                        withAnimation(.spring()) {
//                            if gesture.translation.width < -80 {
//                                offset = -144
//                            } else {
//                                offset = 0
//                            }
//                        }
//                    }
//            )
//        }
//    }
//}
//


// MARK: V32
//import SwiftUI
//
//struct TaskRowView: View {
//    let task: Task
//    let onComplete: () -> Void
//    let onTimer: () -> Void
//    let onNotification: () -> Void
//    
//    @State private var offset: CGFloat = 0
//    
//    var body: some View {
//        ZStack(alignment: .trailing) {
//            // Background options (timer + notification) - circles without rounded backgrounds
//            if offset < -50 {
//                HStack(spacing: 12) {
//                    Button {
//                        withAnimation(.spring()) {
//                            onTimer()
//                            offset = 0
//                        }
//                    } label: {
//                        Circle()
//                            .fill(Color.orange)
//                            .frame(width: 60, height: 60)
//                            .overlay(
//                                Image(systemName: "timer")
//                                    .font(.title2)
//                                    .foregroundColor(.white)
//                            )
//                    }
//                    
//                    Button {
//                        withAnimation(.spring()) {
//                            onNotification()
//                            offset = 0
//                        }
//                    } label: {
//                        Circle()
//                            .fill(Color.purple)
//                            .frame(width: 60, height: 60)
//                            .overlay(
//                                Image(systemName: "bell.fill")
//                                    .font(.title2)
//                                    .foregroundColor(.white)
//                            )
//                    }
//                }
//                .padding(.trailing, 8)
//            }
//            
//            // Task row
//            HStack(spacing: 12) {
//                Button {
//                    withAnimation(.spring(response: 0.3)) {
//                        onComplete()
//                    }
//                } label: {
//                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
//                        .foregroundColor(task.isCompleted ? .green : .gray)
//                        .font(.title2)
//                }
//                
//                Text(task.name)
//                    .strikethrough(task.isCompleted)
//                    .foregroundColor(task.isCompleted ? .gray : .primary)
//                
//                Spacer()
//                
//                HStack(spacing: 8) {
//                    if task.hasTimer {
//                        Image(systemName: "timer")
//                            .foregroundColor(.orange)
//                            .font(.caption)
//                    }
//                    if task.hasNotification {
//                        Image(systemName: "bell.fill")
//                            .foregroundColor(.purple)
//                            .font(.caption)
//                    }
//                }
//            }
//            .padding()
//            .background(Color("TaskColor"))
//            .cornerRadius(25)
//            .offset(x: offset)
//            .gesture(
//                DragGesture()
//                    .onChanged { gesture in
//                        let translation = gesture.translation.width
//                        if translation < 0 {
//                            offset = max(translation, -144)
//                        }
//                    }
//                    .onEnded { gesture in
//                        withAnimation(.spring()) {
//                            if gesture.translation.width < -80 {
//                                offset = -144
//                            } else {
//                                offset = 0
//                            }
//                        }
//                    }
//            )
//        }
//    }
//}
//


// MARK: V34
import SwiftUI

struct TaskRowView: View {
    let task: Task
    let onComplete: () -> Void
    let onTimer: () -> Void
    let onNotification: () -> Void
    
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .trailing) {
            // Background options (timer + notification) - circles without rounded backgrounds
            if offset < -50 {
                HStack(spacing: 12) {
                    Button {
                        withAnimation(.spring()) {
                            onTimer()
                            offset = 0
                        }
                    } label: {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "timer")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            )
                    }
                    
                    Button {
                        withAnimation(.spring()) {
                            onNotification()
                            offset = 0
                        }
                    } label: {
                        Circle()
                            .fill(Color.purple)
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "bell.fill")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            )
                    }
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
//                        .foregroundColor(task.isCompleted ? .green : .white)
                        .foregroundColor(task.isCompleted ? Color(red: 0.6, green: 0.9, blue: 0.6) : .white)
                        .font(.title2)
                }
                
                Text(task.name)
                    .strikethrough(task.isCompleted)
                    .foregroundColor(task.isCompleted ? .gray : .white)
                
                Spacer()
                
                HStack(spacing: 8) {
                    if task.hasTimer {
                        Image(systemName: "timer")
                            .foregroundColor(.orange)
                            .font(.caption)
                    }
                    if task.hasNotification {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.purple)
                            .font(.caption)
                    }
                }
            }
            .padding()
            .background(Color("TaskColor"))
            .cornerRadius(25)
            .offset(x: offset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        let translation = gesture.translation.width
                        if translation < 0 {
                            offset = max(translation, -144)
                        }
                    }
                    .onEnded { gesture in
                        withAnimation(.spring()) {
                            if gesture.translation.width < -80 {
                                offset = -144
                            } else {
                                offset = 0
                            }
                        }
                    }
            )
        }
    }
}

