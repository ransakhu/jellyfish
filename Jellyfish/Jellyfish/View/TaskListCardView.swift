//import SwiftUI
//
//struct TaskListCardView: View {
//    let taskList: TaskList
//    let viewModel: TaskListViewModel
//    let isArchiveView: Bool
//    @State private var offset: CGFloat = 0
//    
//    var body: some View {
//        NavigationLink(destination: TaskDetailView(taskList: taskList, viewModel: viewModel)) {
//            ZStack {
//                // Background actions - positioned absolutely
//                HStack {
//                    // Archive/Unarchive button (swipe right)
//                    if offset > 50 {
//                        Button {
//                            withAnimation(.spring()) {
//                                if isArchiveView {
//                                    viewModel.unarchiveTaskList(taskList)
//                                } else {
//                                    viewModel.archiveTaskList(taskList)
//                                }
//                                offset = 0
//                            }
//                        } label: {
//                            Circle()
//                                .fill(Color.orange)
//                                .frame(width: 50, height: 50)
//                                .overlay(
//                                    Image(systemName: isArchiveView ? "tray.and.arrow.up.fill" : "archivebox.fill")
//                                        .font(.title3)
//                                        .foregroundColor(.white)
//                                )
//                        }
//                        .padding(.leading, 20)
//                    }
//                    
//                    Spacer()
//                    
//                    // Delete button (swipe left) - red circle with trash icon
//                    if offset < -50 {
//                        Button {
//                            withAnimation(.spring()) {
//                                viewModel.deleteTaskListById(taskList.id)
//                            }
//                        } label: {
//                            Circle()
//                                .fill(Color.red)
//                                .frame(width: 50, height: 50)
//                                .overlay(
//                                    Image(systemName: "trash.fill")
//                                        .font(.title3)
//                                        .foregroundColor(.white)
//                                )
//                        }
//                        .padding(.trailing, 20)
//                    }
//                }
//                .frame(height: 80)
//                
//                // Card content - smaller height
//                VStack(alignment: .leading, spacing: 8) {
//                    Text(taskList.name)
//                        .font(.headline)
//                        .foregroundColor(.white)
//                    
//                    if taskList.hasSubTasks {
//                        VStack(alignment: .leading, spacing: 4) {
//                            ProgressView(value: taskList.progress)
//                                .tint(.white)
//                                .scaleEffect(x: 1, y: 1.5, anchor: .center)
//                            
//                            Text("\(Int(taskList.progress * 100))% Complete")
//                                .font(.caption)
//                                .foregroundColor(.white.opacity(0.9))
//                        }
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding()
//                .frame(height: 80)
//                .background(Color("CategoryCard"))
//                .cornerRadius(25)
//                .offset(x: offset)
//                .gesture(
//                    DragGesture()
//                        .onChanged { gesture in
//                            let translation = gesture.translation.width
//                            if translation > 0 {
//                                // Swipe right - archive/unarchive
//                                offset = min(translation, 100)
//                            } else if translation < 0 {
//                                // Swipe left - delete
//                                offset = max(translation, -100)
//                            }
//                        }
//                        .onEnded { gesture in
//                            withAnimation(.spring()) {
//                                let translation = gesture.translation.width
//                                if abs(translation) > 60 {
//                                    offset = translation > 0 ? 100 : -100
//                                } else {
//                                    offset = 0
//                                }
//                            }
//                        }
//                )
//            }
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}


//v23
//import SwiftUI
//
//struct TaskListCardView: View {
//    let taskList: TaskList
//    let viewModel: TaskListViewModel
//    let isArchiveView: Bool
//    @State private var offset: CGFloat = 0
//    
//    var body: some View {
//        NavigationLink(destination: TaskDetailView(taskList: taskList, viewModel: viewModel)) {
//            ZStack {
//                // Background actions - positioned absolutely
//                HStack {
//                    // Archive/Unarchive button (swipe right)
//                    if offset > 50 {
//                        Button {
//                            withAnimation(.spring()) {
//                                if isArchiveView {
//                                    viewModel.unarchiveTaskList(taskList)
//                                } else {
//                                    viewModel.archiveTaskList(taskList)
//                                }
//                                offset = 0
//                            }
//                        } label: {
//                            Circle()
//                                .fill(Color.orange)
//                                .frame(width: 50, height: 50)
//                                .overlay(
//                                    Image(systemName: isArchiveView ? "tray.and.arrow.up.fill" : "archivebox.fill")
//                                        .font(.title3)
//                                        .foregroundColor(.white)
//                                )
//                        }
//                        .padding(.leading, 20)
//                    }
//                    
//                    Spacer()
//                    
//                    // Delete button (swipe left) - red circle with trash icon
//                    if offset < -50 {
//                        Button {
//                            withAnimation(.spring()) {
//                                viewModel.deleteTaskListById(taskList.id)
//                            }
//                        } label: {
//                            Circle()
//                                .fill(Color.red)
//                                .frame(width: 50, height: 50)
//                                .overlay(
//                                    Image(systemName: "trash.fill")
//                                        .font(.title3)
//                                        .foregroundColor(.white)
//                                )
//                        }
//                        .padding(.trailing, 20)
//                    }
//                }
//                .frame(height: 80)
//                
//                // Card content - smaller height
//                VStack(alignment: .leading, spacing: 8) {
//                    Text(taskList.name)
//                        .font(.headline)
//                        .foregroundColor(.white)
//                    
//                    if taskList.hasSubTasks {
//                        VStack(alignment: .leading, spacing: 4) {
//                            ProgressView(value: taskList.progress)
//                                .tint(.white)
//                                .scaleEffect(x: 1, y: 1.5, anchor: .center)
//                            
//                            Text("\(Int(taskList.progress * 100))% Complete")
//                                .font(.caption)
//                                .foregroundColor(.white.opacity(0.9))
//                        }
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding()
//                .frame(height: 80)
//                .background(Color("CategoryCard"))
//                .cornerRadius(25)
//                .offset(x: offset)
//                .gesture(
//                    DragGesture()
//                        .onChanged { gesture in
//                            let translation = gesture.translation.width
//                            if translation > 0 {
//                                // Swipe right - archive/unarchive
//                                offset = min(translation, 100)
//                            } else if translation < 0 {
//                                // Swipe left - delete
//                                offset = max(translation, -100)
//                            }
//                        }
//                        .onEnded { gesture in
//                            withAnimation(.spring()) {
//                                let translation = gesture.translation.width
//                                if abs(translation) > 60 {
//                                    offset = translation > 0 ? 100 : -100
//                                } else {
//                                    offset = 0
//                                }
//                            }
//                        }
//                )
//            }
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}





//MARK: v24
//import SwiftUI
//
//struct TaskListCardView: View {
//    let taskList: TaskList
//    let viewModel: TaskListViewModel
//    let isArchiveView: Bool
//    @State private var offset: CGFloat = 0
//    
//    var body: some View {
//        NavigationLink(destination: TaskDetailView(taskList: taskList, viewModel: viewModel)) {
//            ZStack {
//                // Background actions - positioned absolutely
//                HStack {
//                    // Archive/Unarchive button (swipe right)
//                    if offset > 50 {
//                        Button {
//                            withAnimation(.spring()) {
//                                if isArchiveView {
//                                    viewModel.unarchiveTaskList(taskList)
//                                } else {
//                                    viewModel.archiveTaskList(taskList)
//                                }
//                                offset = 0
//                            }
//                        } label: {
//                            Circle()
//                                .fill(Color.orange)
//                                .frame(width: 50, height: 50)
//                                .overlay(
//                                    Image(systemName: isArchiveView ? "tray.and.arrow.up.fill" : "archivebox.fill")
//                                        .font(.title3)
//                                        .foregroundColor(.white)
//                                )
//                        }
//                        .padding(.leading, 20)
//                    }
//                    
//                    Spacer()
//                    
//                    // Delete button (swipe left) - red circle with trash icon
//                    if offset < -50 {
//                        Button {
//                            withAnimation(.spring()) {
//                                viewModel.deleteTaskListById(taskList.id)
//                            }
//                        } label: {
//                            Circle()
//                                .fill(Color.red)
//                                .frame(width: 50, height: 50)
//                                .overlay(
//                                    Image(systemName: "trash.fill")
//                                        .font(.title3)
//                                        .foregroundColor(.white)
//                                )
//                        }
//                        .padding(.trailing, 20)
//                    }
//                }
//                .frame(height: 80)
//                
//                // Card content - smaller height
//                VStack(alignment: .leading, spacing: 8) {
//                    Text(taskList.name)
//                        .font(.headline)
//                        .foregroundColor(.white)
//                    
//                    if taskList.hasSubTasks {
//                        VStack(alignment: .leading, spacing: 4) {
//                            ProgressView(value: taskList.progress)
//                                .tint(.white)
//                                .scaleEffect(x: 1, y: 1.5, anchor: .center)
//                            
//                            Text("\(Int(taskList.progress * 100))% Complete")
//                                .font(.caption)
//                                .foregroundColor(.white.opacity(0.9))
//                        }
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding()
//                .frame(height: 80)
//                .background(Color("CategoryCard"))
//                .cornerRadius(25)
//                .offset(x: offset)
//                .gesture(
//                    DragGesture()
//                        .onChanged { gesture in
//                            let translation = gesture.translation.width
//                            if translation > 0 {
//                                // Swipe right - archive/unarchive
//                                offset = min(translation, 100)
//                            } else if translation < 0 {
//                                // Swipe left - delete
//                                offset = max(translation, -100)
//                            }
//                        }
//                        .onEnded { gesture in
//                            withAnimation(.spring()) {
//                                let translation = gesture.translation.width
//                                if abs(translation) > 60 {
//                                    offset = translation > 0 ? 100 : -100
//                                } else {
//                                    offset = 0
//                                }
//                            }
//                        }
//                )
//            }
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//


// MARK: V32
//import SwiftUI
//
//struct TaskListCardView: View {
//    let taskList: TaskList
//    let viewModel: TaskListViewModel
//    let isArchiveView: Bool
//    @State private var offset: CGFloat = 0
//    
//    var body: some View {
//        NavigationLink(destination: TaskDetailView(taskList: taskList, viewModel: viewModel)) {
//            ZStack {
//                // Background actions - positioned absolutely
//                HStack {
//                    // Archive/Unarchive button (swipe right)
//                    if offset > 50 {
//                        Button {
//                            withAnimation(.spring()) {
//                                if isArchiveView {
//                                    viewModel.unarchiveTaskList(taskList)
//                                } else {
//                                    viewModel.archiveTaskList(taskList)
//                                }
//                                offset = 0
//                            }
//                        } label: {
//                            Circle()
//                                .fill(Color.orange)
//                                .frame(width: 50, height: 50)
//                                .overlay(
//                                    Image(systemName: isArchiveView ? "tray.and.arrow.up.fill" : "archivebox.fill")
//                                        .font(.title3)
//                                        .foregroundColor(.white)
//                                )
//                        }
//                        .padding(.leading, 20)
//                    }
//                    
//                    Spacer()
//                    
//                    // Delete button (swipe left) - red circle with trash icon
//                    if offset < -50 {
//                        Button {
//                            withAnimation(.spring()) {
//                                viewModel.deleteTaskListById(taskList.id)
//                            }
//                        } label: {
//                            Circle()
//                                .fill(Color.red)
//                                .frame(width: 50, height: 50)
//                                .overlay(
//                                    Image(systemName: "trash.fill")
//                                        .font(.title3)
//                                        .foregroundColor(.white)
//                                )
//                        }
//                        .padding(.trailing, 20)
//                    }
//                }
//                .frame(height: 80)
//                
//                // Card content - smaller height
//                VStack(alignment: .leading, spacing: 8) {
//                    Text(taskList.name)
//                        .font(.headline)
//                        .foregroundColor(.white)
//                    
//                    if taskList.hasSubTasks {
//                        VStack(alignment: .leading, spacing: 4) {
//                            ProgressView(value: taskList.progress)
//                                .tint(.white)
//                                .scaleEffect(x: 1, y: 1.5, anchor: .center)
//                            
//                            Text("\(Int(taskList.progress * 100))% Complete")
//                                .font(.caption)
//                                .foregroundColor(.white.opacity(0.9))
//                        }
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding()
//                .frame(height: 80)
//                .background(Color("CategoryCard"))
//                .cornerRadius(25)
//                .offset(x: offset)
//                .gesture(
//                    DragGesture()
//                        .onChanged { gesture in
//                            let translation = gesture.translation.width
//                            if translation > 0 {
//                                // Swipe right - archive/unarchive
//                                offset = min(translation, 100)
//                            } else if translation < 0 {
//                                // Swipe left - delete
//                                offset = max(translation, -100)
//                            }
//                        }
//                        .onEnded { gesture in
//                            withAnimation(.spring()) {
//                                let translation = gesture.translation.width
//                                if abs(translation) > 60 {
//                                    offset = translation > 0 ? 100 : -100
//                                } else {
//                                    offset = 0
//                                }
//                            }
//                        }
//                )
//            }
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}


// MARK: V34
//import SwiftUI
//
//struct TaskListCardView: View {
//    let taskList: TaskList
//    let viewModel: TaskListViewModel
//    let isArchiveView: Bool
//    @State private var offset: CGFloat = 0
//    
//    var body: some View {
//        NavigationLink(destination: TaskDetailView(taskList: taskList, viewModel: viewModel)) {
//            ZStack {
//                // Background actions - positioned absolutely
//                HStack {
//                    // Archive/Unarchive button (swipe right)
//                    if offset > 50 {
//                        Button {
//                            withAnimation(.spring()) {
//                                if isArchiveView {
//                                    viewModel.unarchiveTaskList(taskList)
//                                } else {
//                                    viewModel.archiveTaskList(taskList)
//                                }
//                                offset = 0
//                            }
//                        } label: {
//                            Circle()
//                                .fill(Color.orange)
//                                .frame(width: 50, height: 50)
//                                .overlay(
//                                    Image(systemName: isArchiveView ? "tray.and.arrow.up.fill" : "archivebox.fill")
//                                        .font(.title3)
//                                        .foregroundColor(.white)
//                                )
//                        }
//                        .padding(.leading, 20)
//                    }
//                    
//                    Spacer()
//                    
//                    // Delete button (swipe left) - red circle with trash icon
//                    if offset < -50 {
//                        Button {
//                            withAnimation(.spring()) {
//                                viewModel.deleteTaskListById(taskList.id)
//                            }
//                        } label: {
//                            Circle()
//                                .fill(Color.red)
//                                .frame(width: 50, height: 50)
//                                .overlay(
//                                    Image(systemName: "trash.fill")
//                                        .font(.title3)
//                                        .foregroundColor(.white)
//                                )
//                        }
//                        .padding(.trailing, 20)
//                    }
//                }
//                .frame(height: 80)
//                
//                // Card content - smaller height
//                VStack(alignment: .leading, spacing: 8) {
//                    Text(taskList.name)
//                        .font(.headline)
//                        .foregroundColor(.white)
//                    
//                    if taskList.hasSubTasks {
//                        VStack(alignment: .leading, spacing: 4) {
//                            ProgressView(value: taskList.progress)
//                                .tint(.white)
//                                .scaleEffect(x: 1, y: 1.5, anchor: .center)
//                            
//                            Text("\(Int(taskList.progress * 100))% Complete")
//                                .font(.caption)
//                                .foregroundColor(.white.opacity(0.9))
//                        }
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding()
//                .frame(height: 80)
//                .background(Color("CategoryCard"))
//                .cornerRadius(25)
//                .offset(x: offset)
//                .gesture(
//                    DragGesture()
//                        .onChanged { gesture in
//                            let translation = gesture.translation.width
//                            if translation > 0 {
//                                // Swipe right - archive/unarchive
//                                offset = min(translation, 100)
//                            } else if translation < 0 {
//                                // Swipe left - delete
//                                offset = max(translation, -100)
//                            }
//                        }
//                        .onEnded { gesture in
//                            withAnimation(.spring()) {
//                                let translation = gesture.translation.width
//                                if abs(translation) > 60 {
//                                    offset = translation > 0 ? 100 : -100
//                                } else {
//                                    offset = 0
//                                }
//                            }
//                        }
//                )
//            }
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}


// MARK: the green progress bar
//import SwiftUI
//
//struct TaskListCardView: View {
//    let taskList: TaskList
//    let viewModel: TaskListViewModel
//    let isArchiveView: Bool
//    @State private var offset: CGFloat = 0
//    
//    var body: some View {
//        NavigationLink(destination: TaskDetailView(taskList: taskList, viewModel: viewModel)) {
//            ZStack {
//                // Background actions - positioned absolutely
//                HStack {
//                    // Archive/Unarchive button (swipe right)
//                    if offset > 50 {
//                        Button {
//                            withAnimation(.spring()) {
//                                if isArchiveView {
//                                    viewModel.unarchiveTaskList(taskList)
//                                } else {
//                                    viewModel.archiveTaskList(taskList)
//                                }
//                                offset = 0
//                            }
//                        } label: {
//                            Circle()
//                                .fill(Color.orange)
//                                .frame(width: 50, height: 50)
//                                .overlay(
//                                    Image(systemName: isArchiveView ? "tray.and.arrow.up.fill" : "archivebox.fill")
//                                        .font(.title3)
//                                        .foregroundColor(.white)
//                                )
//                        }
//                        .padding(.leading, 20)
//                    }
//                    
//                    Spacer()
//                    
//                    // Delete button (swipe left) - red circle with trash icon
//                    if offset < -50 {
//                        Button {
//                            withAnimation(.spring()) {
//                                viewModel.deleteTaskListById(taskList.id)
//                            }
//                        } label: {
//                            Circle()
//                                .fill(Color.red)
//                                .frame(width: 50, height: 50)
//                                .overlay(
//                                    Image(systemName: "trash.fill")
//                                        .font(.title3)
//                                        .foregroundColor(.white)
//                                )
//                        }
//                        .padding(.trailing, 20)
//                    }
//                }
//                .frame(height: 80)
//                
//                // Card content - smaller height
//                VStack(alignment: .leading, spacing: 8) {
//                    Text(taskList.name)
//                        .font(.headline)
//                        .foregroundColor(.white)
//                    
//                    if taskList.hasSubTasks {
//                        VStack(alignment: .leading, spacing: 4) {
//                            ProgressView(value: taskList.progress)
//                                .tint(taskList.progress >= 1.0 ? Color(red: 0.6, green: 0.9, blue: 0.6) : Color.white.opacity(0.5))
//                                .scaleEffect(x: 1, y: 1.5, anchor: .center)
//                            
//                            Text("\(Int(taskList.progress * 100))% Complete")
//                                .font(.caption)
//                                .foregroundColor(taskList.progress >= 1.0 ? Color(red: 0.6, green: 0.9, blue: 0.6) : .white.opacity(0.9))
//                        }
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding()
//                .frame(height: 80)
//                .background(Color("CategoryCard"))
//                .cornerRadius(25)
//                .offset(x: offset)
//                .gesture(
//                    DragGesture()
//                        .onChanged { gesture in
//                            let translation = gesture.translation.width
//                            if translation > 0 {
//                                // Swipe right - archive/unarchive
//                                offset = min(translation, 100)
//                            } else if translation < 0 {
//                                // Swipe left - delete
//                                offset = max(translation, -100)
//                            }
//                        }
//                        .onEnded { gesture in
//                            withAnimation(.spring()) {
//                                let translation = gesture.translation.width
//                                if abs(translation) > 60 {
//                                    offset = translation > 0 ? 100 : -100
//                                } else {
//                                    offset = 0
//                                }
//                            }
//                        }
//                )
//            }
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}


import SwiftUI

struct TaskListCardView: View {
    let taskList: TaskList
    let viewModel: TaskListViewModel
    let isArchiveView: Bool
    @State private var offset: CGFloat = 0
    
    var body: some View {
        NavigationLink(destination: TaskDetailView(taskList: taskList, viewModel: viewModel)) {
            ZStack {
                // Background actions - positioned absolutely
                HStack {
                    // Archive/Unarchive button (swipe right)
                    if offset > 50 {
                        Button {
                            withAnimation(.spring()) {
                                if isArchiveView {
                                    viewModel.unarchiveTaskList(taskList)
                                } else {
                                    viewModel.archiveTaskList(taskList)
                                }
                                offset = 0
                            }
                        } label: {
                            Circle()
                                .fill(Color.orange)
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Image(systemName: isArchiveView ? "tray.and.arrow.up.fill" : "archivebox.fill")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                )
                        }
                        .padding(.leading, 20)
                    }
                    
                    Spacer()
                    
                    // Delete button (swipe left) - red circle with trash icon
                    if offset < -50 {
                        Button {
                            withAnimation(.spring()) {
                                viewModel.deleteTaskListById(taskList.id)
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
                        .padding(.trailing, 20)
                    }
                }
                .frame(height: 80)
                
                // Card content - smaller height
                VStack(alignment: .leading, spacing: 8) {
                    Text(taskList.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    if taskList.hasSubTasks {
                        VStack(alignment: .leading, spacing: 4) {
                            ProgressView(value: taskList.progress)
                                .tint(taskList.progress >= 1.0 ? Color(red: 0.6, green: 0.9, blue: 0.6) : Color.white.opacity(0.5))
                                .scaleEffect(x: 1, y: 1.5, anchor: .center)
                            
                            Text("\(Int(taskList.progress * 100))% Complete")
                                .font(.caption)
                                .foregroundColor(taskList.progress >= 1.0 ? Color(red: 0.6, green: 0.9, blue: 0.6) : .white.opacity(0.9))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .frame(height: 80)
                .background(Color("CategoryCard"))
                .cornerRadius(25)
                .offset(x: offset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            let translation = gesture.translation.width
                            if translation > 0 {
                                // Swipe right - archive/unarchive
                                offset = min(translation, 100)
                            } else if translation < 0 {
                                // Swipe left - delete
                                offset = max(translation, -100)
                            }
                        }
                        .onEnded { gesture in
                            let translation = gesture.translation.width
                            withAnimation(.spring()) {
                                // Hard swipe right - archive immediately
                                if translation > 150 {
                                    if isArchiveView {
                                        viewModel.unarchiveTaskList(taskList)
                                    } else {
                                        viewModel.archiveTaskList(taskList)
                                    }
                                    offset = 0
                                }
                                // Hard swipe left - delete immediately
                                else if translation < -150 {
                                    viewModel.deleteTaskListById(taskList.id)
                                }
                                // Normal swipe - show buttons
                                else if abs(translation) > 60 {
                                    offset = translation > 0 ? 100 : -100
                                }
                                // Not enough swipe - return to normal
                                else {
                                    offset = 0
                                }
                            }
                        }
                )
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
