//import SwiftUI
//
//struct AddListView: View {
//    @ObservedObject var viewModel: TaskListViewModel
//    @State private var listName = ""
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        ZStack {
//            Color("backgroundColor")
//                .ignoresSafeArea()
//            
//            VStack(alignment: .leading, spacing: 20) {
//                Text("List Name")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                    .padding(.top, 20)
//                
//                TextField("Enter list name", text: $listName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .font(.body)
//                
//                Spacer()
//            }
//            .padding()
//        }
//        .navigationTitle("Add List Details")
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
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Save") {
//                    if !listName.trimmingCharacters(in: .whitespaces).isEmpty {
//                        viewModel.addTaskList(name: listName)
//                        dismiss()
//                    }
//                }
//                .fontWeight(.semibold)
//                .foregroundColor(Color("listButton"))
//                .disabled(listName.trimmingCharacters(in: .whitespaces).isEmpty)
//            }
//        }
//    }
//}



//v23
//import SwiftUI
//
//struct AddListView: View {
//    @ObservedObject var viewModel: TaskListViewModel
//    @State private var listName = ""
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        ZStack {
//            Color("backgroundColor")
//                .ignoresSafeArea()
//            
//            VStack(alignment: .leading, spacing: 20) {
//                Text("List Name")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                    .padding(.top, 20)
//                
//                TextField("Enter list name", text: $listName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .font(.body)
//                
//                Spacer()
//            }
//            .padding()
//        }
//        .navigationTitle("Add List Details")
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
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Save") {
//                    if !listName.trimmingCharacters(in: .whitespaces).isEmpty {
//                        viewModel.addTaskList(name: listName)
//                        dismiss()
//                    }
//                }
//                .fontWeight(.semibold)
//                .foregroundColor(Color("listButton"))
//                .disabled(listName.trimmingCharacters(in: .whitespaces).isEmpty)
//            }
//        }
//    }
//}


//MARK: v24 BEST SO FAR
//
//import SwiftUI
//
//struct AddListView: View {
//    @ObservedObject var viewModel: TaskListViewModel
//    @State private var listName = ""
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        ZStack {
//            Color("backgroundColor")
//                .ignoresSafeArea()
//            
//            VStack(alignment: .leading, spacing: 20) {
//                Text("List Name")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                    .padding(.top, 20)
//                
//                TextField("Enter list name", text: $listName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .font(.body)
//                
//                Spacer()
//            }
//            .padding()
//        }
//        .navigationTitle("Add List Details")
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
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Save") {
//                    if !listName.trimmingCharacters(in: .whitespaces).isEmpty {
//                        viewModel.addTaskList(name: listName)
//                        dismiss()
//                    }
//                }
//                .fontWeight(.semibold)
//                .foregroundColor(Color("listButton"))
//                .disabled(listName.trimmingCharacters(in: .whitespaces).isEmpty)
//            }
//        }
//    }
//}
//
//




//MARK: CHAT
//import SwiftUI
//
//struct AddListView: View {
//    @ObservedObject var viewModel: TaskListViewModel
//    
//    @State private var listName = ""
//    @State private var navigateToDetail = false
//    @State private var createdList: TaskList?
//    
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        ZStack {
//            Color("backgroundColor")
//                .ignoresSafeArea()
//            
//            VStack(alignment: .leading, spacing: 20) {
//                
//                // 🔗 Hidden NavigationLink to TaskDetailView after save
//                NavigationLink(
//                    destination: createdListDestination,
//                    isActive: $navigateToDetail,
//                    label: { EmptyView() }
//                )
//                .hidden()
//                
//                Text("List Name")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                    .padding(.top, 20)
//                
//                // You can change style later to match underline design
//                TextField("Enter list name", text: $listName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .font(.body)
//                
//                Spacer()
//            }
//            .padding()
//        }
//        .navigationTitle("Add List Details")
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
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Save") {
//                    let trimmed = listName.trimmingCharacters(in: .whitespaces)
//                    guard !trimmed.isEmpty else { return }
//                    
//                    // 1) create list in the viewModel
//                    let newList = viewModel.addTaskList(name: trimmed)
//                    
//                    // 2) store it so destination knows what to show
//                    createdList = newList
//                    
//                    // 3) trigger navigation to TaskDetailView
//                    navigateToDetail = true
//                }
//                .fontWeight(.semibold)
//                .foregroundColor(Color("listButton"))
//                .disabled(listName.trimmingCharacters(in: .whitespaces).isEmpty)
//            }
//        }
//    }
//    
//    // MARK: - Destination Builder
//    @ViewBuilder
//    private var createdListDestination: some View {
//        if let list = createdList {
//            TaskDetailView(taskList: list, viewModel: viewModel)
//        } else {
//            EmptyView()
//        }
//    }
//}


// MARK: V32
//import SwiftUI
//
//struct AddListView: View {
//    @ObservedObject var viewModel: TaskListViewModel
//    @State private var listName = ""
//    @State private var navigateToDetail = false
//    @State private var createdList: TaskList?
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color("backgroundColor")
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 0) {
//                    // List Name section at top
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("List Name")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                        
//                        TextField("", text: $listName)
//                            .font(.title2)
//                            .fontWeight(.semibold)
//                    }
//                    .padding()
//                    
//                    Spacer()
//                    
//                    // Plus button at bottom
//                    VStack {
//                        Spacer()
//                        
//                        ZStack {
//                            Circle()
//                                .fill(Material.ultraThin)
//                                .frame(width: 85, height: 85)
//                            
//                            Button {
//                                if !listName.trimmingCharacters(in: .whitespaces).isEmpty {
//                                    viewModel.addTaskList(name: listName)
//                                    if let newList = viewModel.taskLists.last {
//                                        createdList = newList
//                                        navigateToDetail = true
//                                    }
//                                }
//                            } label: {
//                                Image(systemName: "plus.circle.fill")
//                                    .font(.system(size: 80))
//                                    .foregroundColor(Color("listButton"))
//                            }
//                            .disabled(listName.trimmingCharacters(in: .whitespaces).isEmpty)
//                            .opacity(listName.trimmingCharacters(in: .whitespaces).isEmpty ? 0.5 : 1.0)
//                        }
//                        .padding(.bottom, 50)
//                    }
//                }
//                
//                NavigationLink(destination: createdList.map { list in
//                    TaskDetailView(taskList: list, viewModel: viewModel)
//                }, isActive: $navigateToDetail) {
//                    EmptyView()
//                }
//            }
//            .navigationTitle("Add List Details")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(Color("listButton"))
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Save") {
//                        dismiss()
//                    }
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("listButton"))
//                }
//            }
//        }
//    }
//}
//


//MARK: V34
import SwiftUI

struct AddListView: View {
    @ObservedObject var viewModel: TaskListViewModel
    @State private var listName = ""
    @State private var isListSaved = false
    @State private var showingAddTask = false
    @State private var createdList: TaskList?
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // List Name section at top - clickable
                Button {
                    if !isListSaved {
                        isTextFieldFocused = true
                    }
                } label: {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("List Name")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        if isListSaved {
                            Text(listName)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                        } else {
                            TextField("Enter list name", text: $listName)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .focused($isTextFieldFocused)
                        }
                        
                        Divider()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
                .disabled(isListSaved)
                
                // Tasks list (only shows after list is saved)
                if isListSaved, let list = createdList {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(list.tasks) { task in
                                HStack(spacing: 12) {
                                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(task.isCompleted ? .green : .gray)
                                        .font(.title2)
                                    
                                    Text(task.name)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color("TaskColor"))
                                .cornerRadius(25)
                            }
                        }
                        .padding()
                        .padding(.bottom, 120)
                    }
                }
                
                Spacer()
                
                // Plus button at bottom (only shows after list is saved)
                if isListSaved {
                    VStack {
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .fill(Material.ultraThin)
                                .frame(width: 85, height: 85)
                            
                            Button {
                                showingAddTask = true
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 80))
                                    .foregroundColor(Color("listButton"))
                            }
                        }
                        .padding(.bottom, 50)
                    }
                }
            }
        }
        .navigationTitle("Add List Details")
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if !isListSaved && !listName.trimmingCharacters(in: .whitespaces).isEmpty {
                        // Save the list name
                        viewModel.addTaskList(name: listName)
                        if let newList = viewModel.taskLists.last {
                            createdList = newList
                            isListSaved = true
                        }
                    } else if isListSaved {
                        // Go back to home
                        dismiss()
                    }
                }
                .fontWeight(.semibold)
                .foregroundColor(Color("listButton"))
                .disabled(!isListSaved && listName.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
        .sheet(isPresented: $showingAddTask) {
            if let list = createdList {
                AddTaskSheetView(taskList: list, viewModel: viewModel) { updatedList in
                    createdList = updatedList
                }
            }
        }
    }
}

// New sheet view for adding tasks
struct AddTaskSheetView: View {
    let taskList: TaskList
    let viewModel: TaskListViewModel
    let onTaskAdded: (TaskList) -> Void
    
    @State private var taskName = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("backgroundColor")
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Task Name")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                    
                    TextField("Enter task name", text: $taskName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.body)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Add Task Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color("listButton"))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if !taskName.trimmingCharacters(in: .whitespaces).isEmpty {
                            var updatedList = taskList
                            let newTask = Task(name: taskName)
                            updatedList.tasks.append(newTask)
                            viewModel.updateTaskList(updatedList)
                            onTaskAdded(updatedList)
                            dismiss()
                        }
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(Color("listButton"))
                    .disabled(taskName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

