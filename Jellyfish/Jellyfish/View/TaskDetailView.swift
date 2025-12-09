
//MARK: without X and check
import SwiftUI

struct TaskDetailView: View {
    @StateObject private var viewModel: TaskDetailViewModel
    @StateObject private var timerVM = TimerViewModel()
// انا
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
            // Background color
            Color("backgroundColor")
                .ignoresSafeArea()
                .onTapGesture {
                    // Save task when tapping outside
                    if isAddingTask && !newTaskName.trimmingCharacters(in: .whitespaces).isEmpty {
                        saveNewTask()
                    }
                    newTaskFocused = false
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
                        LazyVStack(spacing: 12) {
                            // New task input box (appears when adding)
                            if isAddingTask {
                                VStack {
                                    HStack(spacing: 12) {
                                        ZStack(alignment: .leading) {
                                            if newTaskName.isEmpty {
                                                Text("Task name..")
                                                    .foregroundColor(.gray.opacity(0.4))
                                                    .font(.body)
                                            }
                                            TextField("", text: $newTaskName)
                                                .font(.body)
                                                .foregroundColor(.white)
                                                .focused($newTaskFocused)
                                                .submitLabel(.done)
                                                .onSubmit {
                                                    if !newTaskName.trimmingCharacters(in: .whitespaces).isEmpty {
                                                        saveNewTask()
                                                    }
                                                }
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                                .frame(height: 73)
                                .background(Color("TaskColor"))
                                .cornerRadius(25)
                                .transition(.move(edge: .top).combined(with: .opacity))
                                .onTapGesture {
                                    // Keep focus when tapping on the input box
                                    newTaskFocused = true
                                }
                            }
                            
                            // Sort: incomplete tasks first, completed tasks last
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
                                        viewModel.enableTimer(for: task)
                                        showingTimerScreen = true
                                    },
                                    onNotification: {
                                        selectedTask = task
                                        showingReminderSheet = true
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
            
            // Blur effect and button at bottom
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
        .sheet(isPresented: $showingReminderSheet) {
            AddReminderModalView()
        }
        .fullScreenCover(isPresented: $showingTimerScreen) {
            if let task = selectedTask {
                NavigationView {
                    FocusTimerScreen(viewModel: timerVM)   // ✅ نمرّر نفس التايمر
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Done") {
                                    timerVM.startFocus()      // 🔥 يبدأ التايمر
                                    showingTimerScreen = false                                //rand
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
        isAddingTask = false
    }
}
