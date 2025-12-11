
import SwiftUI

struct TaskDetailView: View {
    @StateObject private var viewModel: TaskDetailViewModel
    @StateObject private var timerVM = TimerViewModel()
    
    @State private var selectedTask: Task?
    @State private var showingTimerScreen = false
    @State private var isAddingTask = false
    @State private var newTaskName = ""
    @State private var showingReminderSheet = false
    @FocusState private var newTaskFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    init(taskList: TaskList, viewModel: TaskListViewModel) {
        _viewModel = StateObject(wrappedValue: TaskDetailViewModel(taskList: taskList, parentViewModel: viewModel))
    }
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
                .onTapGesture {
                    if isAddingTask && !newTaskName.trimmingCharacters(in: .whitespaces).isEmpty {
                        saveNewTask()
                    }
                    newTaskFocused = false
                    isAddingTask = false
                }
            
            VStack(spacing: 0) {
                if viewModel.taskList.tasks.isEmpty && !isAddingTask {
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
                        LazyVStack(spacing: 0) {
                            if isAddingTask {
                                VStack(spacing: 0) {
                                    HStack(spacing: 12) {
                                        Image(systemName: "circle")
                                            .foregroundColor(.gray)
                                            .font(.title2)
                                        
                                        ZStack(alignment: .leading) {
                                            if newTaskName.isEmpty {
                                                Text("Task name..")
                                                    .foregroundColor(.gray.opacity(0.4))
                                                    .font(.body)
                                            }
                                            TextField("", text: $newTaskName)
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .focused($newTaskFocused)
                                                .submitLabel(.return)
                                                .onSubmit {
                                                    if !newTaskName.trimmingCharacters(in: .whitespaces).isEmpty {
                                                        saveNewTask()
                                                        // Keep adding mode active and refocus
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                            isAddingTask = true
                                                            newTaskFocused = true
                                                        }
                                                    }
                                                }
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 20)
                                    .frame(height: 60)
                                    
                                    Divider()
                                        .background(Color.gray.opacity(0.3))
                                        .padding(.leading, 52)
                                }
                                .transition(.move(edge: .top).combined(with: .opacity))
                                .onTapGesture {
                                    newTaskFocused = true
                                }
                            }
                            
                            let sortedTasks = viewModel.taskList.tasks.sorted { task1, task2 in
                                if task1.isCompleted && !task2.isCompleted {
                                    return false
                                } else if !task1.isCompleted && task2.isCompleted {
                                    return true
                                }
                                return false
                            }
                            
                            ForEach(sortedTasks) { task in
                                TaskRowView(
                                    task: task,
                                    onComplete: {
                                        viewModel.toggleTaskCompletion(task)
                                    },
                                    onTimer: {
                                        selectedTask = task
                                        if task.hasTimer {
                                            viewModel.disableTimer(for: task)
                                        } else {
                                            viewModel.enableTimer(for: task)
                                            showingTimerScreen = true
                                        }
                                    },
                                    onNotification: {
                                        selectedTask = task
                                        if task.hasNotification {
                                            viewModel.disableNotification(for: task)
                                        } else {
                                            showingReminderSheet = true
                                        }
                                    },
                                    onDelete: {
                                        viewModel.deleteTask(task)
                                    }
                                )
                            }
                        }
                        .padding()
                        .padding(.bottom, 180)
                    }
                }
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(height: 200)
                        .mask(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: .clear, location: 0),
                                    .init(color: .white, location: 0.4),
                                    .init(color: .white, location: 1)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    Button {
                        withAnimation {
                            isAddingTask = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            newTaskFocused = true
                        }
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color("listButton"))
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
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color("listButton"))
                }
            }
        }
        .sheet(isPresented: $showingReminderSheet) {
            AddReminderModalView()
                .onDisappear {
                    if let task = selectedTask {
                        viewModel.enableNotification(for: task, date: Date())
                    }
                }
        }
        .fullScreenCover(isPresented: $showingTimerScreen) {
            if let task = selectedTask {
                NavigationView {
                    FocusTimerScreen(viewModel: timerVM)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Done") {
                                    timerVM.startFocus()
                                    showingTimerScreen = false
                                }
                            }
                        }
                }
            }
        }
    }
    
    private func saveNewTask() {
        viewModel.addTask(name: newTaskName)
        newTaskName = ""
    }
}
