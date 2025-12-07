//import SwiftUI
//
//struct TaskDetailView: View {
//    @StateObject private var viewModel: TaskDetailViewModel
//    @State private var selectedTask: Task?
//    @State private var showingTimerScreen = false
//    @Environment(\.dismiss) private var dismiss
//    
//    init(taskList: TaskList, viewModel: TaskListViewModel) {
//        _viewModel = StateObject(wrappedValue: TaskDetailViewModel(taskList: taskList, parentViewModel: viewModel))
//    }
//    
//    var body: some View {
//        ZStack {
//            // Background color
//            Color("backgroundColor")
//                .ignoresSafeArea()
//            
//            VStack(spacing: 0) {
//                if viewModel.taskList.tasks.isEmpty {
//                    VStack(spacing: 12) {
//                        Image(systemName: "checklist")
//                            .font(.system(size: 60))
//                            .foregroundColor(.gray.opacity(0.5))
//                        Text("No tasks yet")
//                            .font(.headline)
//                            .foregroundColor(.gray)
//                        Text("Tap + to add your first task")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                    .frame(maxHeight: .infinity)
//                } else {
//                    ScrollView {
//                        LazyVStack(spacing: 12) {
//                            ForEach(viewModel.taskList.tasks) { task in
//                                TaskRowView(
//                                    task: task,
//                                    onComplete: {
//                                        viewModel.toggleTaskCompletion(task)
//                                    },
//                                    onTimer: {
//                                        selectedTask = task
//                                        viewModel.enableTimer(for: task)
//                                        showingTimerScreen = true
//                                    },
//                                    onNotification: {
//                                        viewModel.enableNotification(for: task, date: Date())
//                                    }
//                                )
//                            }
//                        }
//                        .padding()
//                        .padding(.bottom, 100) // Space for floating button
//                    }
//                }
//                
//                // Big floating plus button at bottom - glassy
//                VStack {
//                    Spacer()
//                    Button {
//                        viewModel.showingAddTask = true
//                    } label: {
//                        ZStack {
//                            Circle()
//                                .fill(.ultraThinMaterial)
//                                .frame(width: 85, height: 85)
//                            
//                            Image(systemName: "plus.circle.fill")
//                                .font(.system(size: 80))
//                                .foregroundColor(Color("listButton"))
//                        }
//                    }
//                    .padding(.bottom, 50)
//                }
//            }
//        }
//        .navigationTitle(viewModel.taskList.name)
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    dismiss()
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(Color("listButton"))
//                }
//            }
//        }
//        .sheet(isPresented: $viewModel.showingAddTask) {
//            AddTaskView(viewModel: viewModel)
//        }
//        .fullScreenCover(isPresented: $showingTimerScreen) {
//            if let task = selectedTask {
//                NavigationView {
//                    FocusTimerScreen()
//                        .navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem(placement: .navigationBarLeading) {
//                                Button("Done") {
//                                    showingTimerScreen = false
//                                }
//                            }
//                        }
//                }
//            }
//        }
//    }
//}





//v23
//import SwiftUI
//
//struct TaskDetailView: View {
//    @StateObject private var viewModel: TaskDetailViewModel
//    @State private var selectedTask: Task?
//    @State private var showingTimerScreen = false
//    @Environment(\.dismiss) private var dismiss
//    
//    init(taskList: TaskList, viewModel: TaskListViewModel) {
//        _viewModel = StateObject(wrappedValue: TaskDetailViewModel(taskList: taskList, parentViewModel: viewModel))
//    }
//    
//    var body: some View {
//        ZStack {
//            // Background color
//            Color("backgroundColor")
//                .ignoresSafeArea()
//            
//            VStack(spacing: 0) {
//                if viewModel.taskList.tasks.isEmpty {
//                    VStack(spacing: 12) {
//                        Image(systemName: "checklist")
//                            .font(.system(size: 60))
//                            .foregroundColor(.gray.opacity(0.5))
//                        Text("No tasks yet")
//                            .font(.headline)
//                            .foregroundColor(.gray)
//                        Text("Tap + to add your first task")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                    .frame(maxHeight: .infinity)
//                } else {
//                    ScrollView {
//                        LazyVStack(spacing: 12) {
//                            ForEach(viewModel.taskList.tasks) { task in
//                                TaskRowView(
//                                    task: task,
//                                    onComplete: {
//                                        viewModel.toggleTaskCompletion(task)
//                                    },
//                                    onTimer: {
//                                        selectedTask = task
//                                        viewModel.enableTimer(for: task)
//                                        showingTimerScreen = true
//                                    },
//                                    onNotification: {
//                                        viewModel.enableNotification(for: task, date: Date())
//                                    }
//                                )
//                            }
//                        }
//                        .padding()
//                        .padding(.bottom, 100) // Space for floating button
//                    }
//                }
//                
//                // Big floating plus button at bottom - glassy
//                VStack {
//                    Spacer()
//                    
//                    ZStack {
//                        Circle()
//                            .fill(Material.ultraThin)
//                            .frame(width: 85, height: 85)
//                        
//                        Button {
//                            viewModel.showingAddTask = true
//                        } label: {
//                            Image(systemName: "plus.circle.fill")
//                                .font(.system(size: 80))
//                                .foregroundColor(Color("listButton"))
//                        }
//                    }
//                    .padding(.bottom, 50)
//                }
//            }
//        }
//        .navigationTitle(viewModel.taskList.name)
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    dismiss()
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(Color("listButton"))
//                }
//            }
//        }
//        .sheet(isPresented: $viewModel.showingAddTask) {
//            AddTaskView(viewModel: viewModel)
//        }
//        .fullScreenCover(isPresented: $showingTimerScreen) {
//            if let task = selectedTask {
//                NavigationView {
//                    FocusTimerScreen()
//                        .navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem(placement: .navigationBarLeading) {
//                                Button("Done") {
//                                    showingTimerScreen = false
//                                }
//                            }
//                        }
//                }
//            }
//        }
//    }
//}


//MARK: v24

//import SwiftUI
//
//struct TaskDetailView: View {
//    @StateObject private var viewModel: TaskDetailViewModel
//    @State private var selectedTask: Task?
//    @State private var showingTimerScreen = false
//    @Environment(\.dismiss) private var dismiss
//    
//    init(taskList: TaskList, viewModel: TaskListViewModel) {
//        _viewModel = StateObject(wrappedValue: TaskDetailViewModel(taskList: taskList, parentViewModel: viewModel))
//    }
//    
//    var body: some View {
//        ZStack {
//            // Background color
//            Color("backgroundColor")
//                .ignoresSafeArea()
//            
//            VStack(spacing: 0) {
//                if viewModel.taskList.tasks.isEmpty {
//                    VStack(spacing: 12) {
//                        Image(systemName: "checklist")
//                            .font(.system(size: 60))
//                            .foregroundColor(.gray.opacity(0.5))
//                        Text("No tasks yet")
//                            .font(.headline)
//                            .foregroundColor(.gray)
//                        Text("Tap + to add your first task")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                    .frame(maxHeight: .infinity)
//                } else {
//                    ScrollView {
//                        LazyVStack(spacing: 12) {
//                            ForEach(viewModel.taskList.tasks) { task in
//                                TaskRowView(
//                                    task: task,
//                                    onComplete: {
//                                        viewModel.toggleTaskCompletion(task)
//                                    },
//                                    onTimer: {
//                                        selectedTask = task
//                                        viewModel.enableTimer(for: task)
//                                        showingTimerScreen = true
//                                    },
//                                    onNotification: {
//                                        viewModel.enableNotification(for: task, date: Date())
//                                    }
//                                )
//                            }
//                        }
//                        .padding()
//                        .padding(.bottom, 100) // Space for floating button
//                    }
//                }
//                
//                // Big floating plus button at bottom - glassy
//                VStack {
//                    Spacer()
//                    
//                    ZStack {
//                        Circle()
//                            .fill(Material.ultraThin)
//                            .frame(width: 85, height: 85)
//                        
//                        Button {
//                            viewModel.showingAddTask = true
//                        } label: {
//                            Image(systemName: "plus.circle.fill")
//                                .font(.system(size: 80))
//                                .foregroundColor(Color("listButton"))
//                        }
//                    }
//                    .padding(.bottom, 50)
//                }
//            }
//        }
//        .navigationTitle(viewModel.taskList.name)
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    dismiss()
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(Color("listButton"))
//                }
//            }
//        }
//        .sheet(isPresented: $viewModel.showingAddTask) {
//            AddTaskView(viewModel: viewModel)
//        }
//        .fullScreenCover(isPresented: $showingTimerScreen) {
//            if let task = selectedTask {
//                NavigationView {
//                    FocusTimerScreen()
//                        .navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem(placement: .navigationBarLeading) {
//                                Button("Done") {
//                                    showingTimerScreen = false
//                                }
//                            }
//                        }
//                }
//            }
//        }
//    }
//}



// MARK: V32
//import SwiftUI
//
//struct TaskDetailView: View {
//    @StateObject private var viewModel: TaskDetailViewModel
//    @State private var selectedTask: Task?
//    @State private var showingTimerScreen = false
//    @Environment(\.dismiss) private var dismiss
//    
//    init(taskList: TaskList, viewModel: TaskListViewModel) {
//        _viewModel = StateObject(wrappedValue: TaskDetailViewModel(taskList: taskList, parentViewModel: viewModel))
//    }
//    
//    var body: some View {
//        ZStack {
//            // Background color
//            Color("backgroundColor")
//                .ignoresSafeArea()
//            
//            VStack(spacing: 0) {
//                if viewModel.taskList.tasks.isEmpty {
//                    VStack(spacing: 12) {
//                        Image(systemName: "checklist")
//                            .font(.system(size: 60))
//                            .foregroundColor(.gray.opacity(0.5))
//                        Text("No tasks yet")
//                            .font(.headline)
//                            .foregroundColor(.gray)
//                        Text("Tap + to add your first task")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                    .frame(maxHeight: .infinity)
//                } else {
//                    ScrollView {
//                        LazyVStack(spacing: 12) {
//                            ForEach(viewModel.taskList.tasks) { task in
//                                TaskRowView(
//                                    task: task,
//                                    onComplete: {
//                                        viewModel.toggleTaskCompletion(task)
//                                    },
//                                    onTimer: {
//                                        selectedTask = task
//                                        viewModel.enableTimer(for: task)
//                                        showingTimerScreen = true
//                                    },
//                                    onNotification: {
//                                        viewModel.enableNotification(for: task, date: Date())
//                                    }
//                                )
//                            }
//                        }
//                        .padding()
//                        .padding(.bottom, 100) // Space for floating button
//                    }
//                }
//                
//                // Big floating plus button at bottom - glassy
//                VStack {
//                    Spacer()
//                    
//                    ZStack {
//                        Circle()
//                            .fill(Material.ultraThin)
//                            .frame(width: 85, height: 85)
//                        
//                        Button {
//                            viewModel.showingAddTask = true
//                        } label: {
//                            Image(systemName: "plus.circle.fill")
//                                .font(.system(size: 80))
//                                .foregroundColor(Color("listButton"))
//                        }
//                    }
//                    .padding(.bottom, 50)
//                }
//            }
//        }
//        .navigationTitle(viewModel.taskList.name)
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    dismiss()
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(Color("listButton"))
//                }
//            }
//        }
//        .sheet(isPresented: $viewModel.showingAddTask) {
//            AddTaskView(viewModel: viewModel)
//        }
//        .fullScreenCover(isPresented: $showingTimerScreen) {
//            if let task = selectedTask {
//                NavigationView {
//                    FocusTimerScreen()
//                        .navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem(placement: .navigationBarLeading) {
//                                Button("Done") {
//                                    showingTimerScreen = false
//                                }
//                            }
//                        }
//                }
//            }
//        }
//    }
//}
//


// MARK: V34
//import SwiftUI
//
//struct TaskDetailView: View {
//    @StateObject private var viewModel: TaskDetailViewModel
//    @State private var selectedTask: Task?
//    @State private var showingTimerScreen = false
//    @Environment(\.dismiss) private var dismiss
//    
//    init(taskList: TaskList, viewModel: TaskListViewModel) {
//        _viewModel = StateObject(wrappedValue: TaskDetailViewModel(taskList: taskList, parentViewModel: viewModel))
//    }
//    
//    var body: some View {
//        ZStack {
//            // Background color
//            Color("backgroundColor")
//                .ignoresSafeArea()
//            
//            VStack(spacing: 0) {
//                if viewModel.taskList.tasks.isEmpty {
//                    VStack(spacing: 12) {
//                        Image(systemName: "checklist")
//                            .font(.system(size: 60))
//                            .foregroundColor(.gray.opacity(0.5))
//                        Text("No tasks yet")
//                            .font(.headline)
//                            .foregroundColor(.gray)
//                        Text("Tap + to add your first task")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                    .frame(maxHeight: .infinity)
//                } else {
//                    ScrollView {
//                        LazyVStack(spacing: 12) {
//                            ForEach(viewModel.taskList.tasks) { task in
//                                TaskRowView(
//                                    task: task,
//                                    onComplete: {
//                                        viewModel.toggleTaskCompletion(task)
//                                    },
//                                    onTimer: {
//                                        selectedTask = task
//                                        viewModel.enableTimer(for: task)
//                                        showingTimerScreen = true
//                                    },
//                                    onNotification: {
//                                        viewModel.enableNotification(for: task, date: Date())
//                                    }
//                                )
//                            }
//                        }
//                        .padding()
//                        .padding(.bottom, 100) // Space for floating button
//                    }
//                }
//                
//                // Big floating plus button at bottom - glassy
//                VStack {
//                    Spacer()
//                    
//                    ZStack {
//                        Circle()
//                            .fill(Material.ultraThin)
//                            .frame(width: 85, height: 85)
//                        
//                        Button {
//                            viewModel.showingAddTask = true
//                        } label: {
//                            Image(systemName: "plus.circle.fill")
//                                .font(.system(size: 80))
//                                .foregroundColor(Color("listButton"))
//                        }
//                    }
//                    .padding(.bottom, 50)
//                }
//            }
//        }
//        .navigationTitle(viewModel.taskList.name)
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    dismiss()
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(Color("listButton"))
//                }
//            }
//        }
//        .sheet(isPresented: $viewModel.showingAddTask) {
//            AddTaskView(viewModel: viewModel)
//        }
//        .fullScreenCover(isPresented: $showingTimerScreen) {
//            if let task = selectedTask {
//                NavigationView {
//                    FocusTimerScreen()
//                        .navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem(placement: .navigationBarLeading) {
//                                Button("Done") {
//                                    showingTimerScreen = false
//                                }
//                            }
//                        }
//                }
//            }
//        }
//    }
//}
//
//
// MARK: v1 D
//import SwiftUI
//
//struct TaskDetailView: View {
//    @StateObject private var viewModel: TaskDetailViewModel
//    @State private var selectedTask: Task?
//    @State private var showingTimerScreen = false
//    @Environment(\.dismiss) private var dismiss
//    
//    init(taskList: TaskList, viewModel: TaskListViewModel) {
//        _viewModel = StateObject(wrappedValue: TaskDetailViewModel(taskList: taskList, parentViewModel: viewModel))
//    }
//    
//    var body: some View {
//        ZStack {
//            // Background color
//            Color("backgroundColor")
//                .ignoresSafeArea()
//            
//            VStack(spacing: 0) {
//                if viewModel.taskList.tasks.isEmpty {
//                    VStack(spacing: 12) {
//                        Image(systemName: "checklist")
//                            .font(.system(size: 60))
//                            .foregroundColor(.gray.opacity(0.5))
//                        Text("No tasks yet")
//                            .font(.headline)
//                            .foregroundColor(.gray)
//                        Text("Tap + to add your first task")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                    .frame(maxHeight: .infinity)
//                } else {
//                    ScrollView {
//                        LazyVStack(spacing: 12) {
//                            ForEach(viewModel.taskList.tasks) { task in
//                                TaskRowView(
//                                    task: task,
//                                    onComplete: {
//                                        viewModel.toggleTaskCompletion(task)
//                                    },
//                                    onTimer: {
//                                        selectedTask = task
//                                        viewModel.enableTimer(for: task)
//                                        showingTimerScreen = true
//                                    },
//                                    onNotification: {
//                                        viewModel.enableNotification(for: task, date: Date())
//                                    }
//                                )
//                            }
//                        }
//                        .padding()
//                        .padding(.bottom, 180) // Space for blur and button
//                    }
//                }
//                
//                Spacer()
//            }
//            
//            // Blur effect and button at bottom
//            VStack {
//                Spacer()
//                
//                ZStack(alignment: .bottom) {
//                    // Blur background
//                    Rectangle()
//                        .fill(.ultraThinMaterial)
//                        .frame(height: 150)
//                        .mask(
//                            LinearGradient(
//                                gradient: Gradient(stops: [
//                                    .init(color: .clear, location: 0),
//                                    .init(color: .white, location: 0.3),
//                                    .init(color: .white, location: 1)
//                                ]),
//                                startPoint: .top,
//                                endPoint: .bottom
//                            )
//                        )
//                    
//                   
//                    // Plus button
//                    // Plus button
//                    Button {
//                        viewModel.showingAddTask = true
//                    } label: {
//                        ZStack {
//                            Circle()
//                                .fill(Color(red: 38/255, green: 38/255, blue: 80/255))
//                                .frame(width: 80, height: 80)
//                            
//                            Image(systemName: "plus")
//                                .font(.system(size: 40, weight: .semibold))
//                                .foregroundColor(Color("backgroundColor"))
//                        }
//                    }
//                    .padding(.bottom, 35)
//                }
//                .frame(height: 150)
//            }
//        }
//        .navigationTitle(viewModel.taskList.name)
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    dismiss()
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(Color("listButton"))
//                }
//            }
//        }
//        .sheet(isPresented: $viewModel.showingAddTask) {
//            AddTaskView(viewModel: viewModel)
//        }
//        .fullScreenCover(isPresented: $showingTimerScreen) {
//            if let task = selectedTask {
//                NavigationView {
//                    FocusTimerScreen()
//                        .navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem(placement: .navigationBarLeading) {
//                                Button("Done") {
//                                    showingTimerScreen = false
//                                }
//                            }
//                        }
//                }
//            }
//        }
//    }
//}
//MARK: V2 trying to fix the padding
import SwiftUI

struct TaskDetailView: View {
    @StateObject private var viewModel: TaskDetailViewModel
    @State private var selectedTask: Task?
    @State private var showingTimerScreen = false
    @Environment(\.dismiss) private var dismiss
    
    init(taskList: TaskList, viewModel: TaskListViewModel) {
        _viewModel = StateObject(wrappedValue: TaskDetailViewModel(taskList: taskList, parentViewModel: viewModel))
    }
    
    var body: some View {
        ZStack {
            // Background color
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                if viewModel.taskList.tasks.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "checklist")
                            .font(.system(size: 60))
                            .foregroundColor(.gray.opacity(0.5))
                        Text("No tasks yet")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("Tap + to add your first task")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.taskList.tasks) { task in
                                TaskRowView(
                                    task: task,
                                    onComplete: {
                                        viewModel.toggleTaskCompletion(task)
                                    },
                                    onTimer: {
                                        selectedTask = task
                                        viewModel.enableTimer(for: task)
                                        showingTimerScreen = true
                                    },
                                    onNotification: {
                                        viewModel.enableNotification(for: task, date: Date())
                                    }
                                )
                            }
                        }
                        .padding()
                        .padding(.bottom, 180) // Space for blur and button
                    }
                }
                
                Spacer()
            }
            
            // Blur effect and button at bottom
            VStack {
                Spacer()
                
                ZStack(alignment: .bottom) {
                    // Blur background
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(height: 200)
                        .mask(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: .clear, location: 0),
                                    .init(color: .white, location: 0.5),
                                    .init(color: .white, location: 0.7)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    // Plus button
                    Button {
                        viewModel.showingAddTask = true
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color(red: 38/255, green: 38/255, blue: 80/255))
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 40, weight: .semibold))
                                .foregroundColor(Color("backgroundColor"))
                        }
                    }
                    .padding(.bottom, 50)
                }
                .frame(height: 200)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationTitle(viewModel.taskList.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("listButton"))
                }
            }
        }
        .sheet(isPresented: $viewModel.showingAddTask) {
            AddTaskView(viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $showingTimerScreen) {
            if let task = selectedTask {
                NavigationView {
                    FocusTimerScreen()
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Done") {
                                    showingTimerScreen = false
                                }
                            }
                        }
                }
            }
        }
    }
}
