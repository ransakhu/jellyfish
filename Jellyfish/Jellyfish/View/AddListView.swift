/*
import SwiftUI

struct AddListView: View {
    @ObservedObject var viewModel: TaskListViewModel
    @State private var listName = ""
    @State private var isListSaved = false
    @State private var createdList: TaskList?
    @State private var isAddingTask = false
    @State private var newTaskName = ""
    @FocusState private var isTextFieldFocused: Bool
    @FocusState private var newTaskFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
                .onTapGesture {
                    // Save task when tapping outside
                    if isAddingTask && !newTaskName.trimmingCharacters(in: .whitespaces).isEmpty {
                        saveNewTask()
                    }
                    newTaskFocused = false
                    isTextFieldFocused = false
                }
            
            VStack(alignment: .leading, spacing: 0) {
                // List name input at top left
                VStack(alignment: .leading, spacing: 8) {
                    ZStack(alignment: .leading) {
                        if listName.isEmpty && !isListSaved {
                            Text("List name..")
                                .foregroundColor(.gray.opacity(0.4))
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        if isListSaved {
                            Text(listName)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        } else {
                            TextField("", text: $listName)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .focused($isTextFieldFocused)
                        }
                    }
                    
                    Divider()
                        .background(.black.opacity(0.3))
                }
                .padding()
                
                // Tasks list (only shows after list is saved)
                if isListSaved {
                    if let list = createdList, list.tasks.isEmpty && !isAddingTask {
                        // Empty state
                        Spacer()
                        
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
                        .frame(maxWidth: .infinity)
                        
                        Spacer()
                    } else if let list = createdList {
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
                                
                                ForEach(list.tasks) { task in
                                    HStack(spacing: 12) {
                                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(task.isCompleted ? Color(red: 0.6, green: 0.9, blue: 0.6) : .white)
                                            .font(.title2)
                                        
                                        Text(task.name)
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 16)
                                    .frame(height: 73)
                                    .background(Color("TaskColor"))
                                    .cornerRadius(25)
                                }
                            }
                            .padding()
                            .padding(.bottom, 180)
                        }
                    }
                }
                
                Spacer()
            }
            
            // Plus button at bottom (only shows after list is saved)
            if isListSaved {
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
        }
        .navigationTitle("")
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
                Button(isListSaved ? "Done" : "Save") {
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
        .onAppear {
            isTextFieldFocused = true
        }
    }
    
    private func saveNewTask() {
        guard let list = createdList else { return }
        var updatedList = list
        let newTask = Task(name: newTaskName)
        updatedList.tasks.append(newTask)
        viewModel.updateTaskList(updatedList)
        createdList = updatedList
        newTaskName = ""
        // Don't set isAddingTask to false - keep it true to show new empty box
        // isAddingTask = false
        
        // Keep focus on the text field for next task
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            newTaskFocused = true
        }
    }
} */
import SwiftUI

struct AddListView: View {
    @ObservedObject var viewModel: TaskListViewModel
    @State private var listName = ""
    @State private var isListSaved = false
    @State private var createdList: TaskList?
    @State private var isAddingTask = false
    @State private var newTaskName = ""
    @FocusState private var isTextFieldFocused: Bool
    @FocusState private var newTaskFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
                .onTapGesture {
                    if isAddingTask && !newTaskName.trimmingCharacters(in: .whitespaces).isEmpty {
                        saveNewTask()
                    }
                    newTaskFocused = false
                    isTextFieldFocused = false
                }
            
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    ZStack(alignment: .leading) {
                        if listName.isEmpty && !isListSaved {
                            Text("List name..")
                                .foregroundColor(.gray.opacity(0.4))
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        if isListSaved {
                            Text(listName)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        } else {
                            TextField("", text: $listName)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .focused($isTextFieldFocused)
                        }
                    }
                    
                    Divider()
                        .background(.black.opacity(0.3))
                }
                .padding()
                
                if isListSaved {
                    if let list = createdList, list.tasks.isEmpty && !isAddingTask {
                        Spacer()
                        
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
                        .frame(maxWidth: .infinity)
                        
                        Spacer()
                    } else if let list = createdList {
                        ScrollView {
                            LazyVStack(spacing: 12) {
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
                                    .padding(.vertical, 20)
                                    .frame(height: 85)
                                    .background(Color("TaskColor"))
                                    .cornerRadius(25)
                                    .transition(.move(edge: .top).combined(with: .opacity))
                                    .onTapGesture {
                                        newTaskFocused = true
                                    }
                                }
                                
                                ForEach(list.tasks) { task in
                                    HStack(spacing: 12) {
                                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(task.isCompleted ? Color(red: 0.6, green: 0.9, blue: 0.6) : .white)
                                            .font(.title2)
                                        
                                        Text(task.name)
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 20)
                                    .frame(height: 85)
                                    .background(Color("TaskColor"))
                                    .cornerRadius(25)
                                }
                            }
                            .padding()
                            .padding(.bottom, 180)
                        }
                    }
                }
                
                Spacer()
            }
            
            if isListSaved {
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
        }
        .navigationTitle("")
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isListSaved ? "Done" : "Save") {
                    if !isListSaved && !listName.trimmingCharacters(in: .whitespaces).isEmpty {
                        viewModel.addTaskList(name: listName)
                        if let newList = viewModel.taskLists.last {
                            createdList = newList
                            isListSaved = true
                        }
                    } else if isListSaved {
                        dismiss()
                    }
                }
                .fontWeight(.semibold)
                .foregroundColor(Color("listButton"))
                .disabled(!isListSaved && listName.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
        .onAppear {
            isTextFieldFocused = true
        }
    }
    
    private func saveNewTask() {
        guard let list = createdList else { return }
        var updatedList = list
        let newTask = Task(name: newTaskName)
        updatedList.tasks.append(newTask)
        viewModel.updateTaskList(updatedList)
        createdList = updatedList
        newTaskName = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            newTaskFocused = true
        }
    }
}
