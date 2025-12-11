

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
                    isAddingTask = false
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
                                                            // Keep adding mode and refocus
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
                                
                                ForEach(list.tasks) { task in
                                    VStack(spacing: 0) {
                                        HStack(spacing: 12) {
                                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                                .foregroundColor(task.isCompleted ? Color(red: 0.6, green: 0.9, blue: 0.6) : .gray)
                                                .font(.title2)
                                            
                                            Text(task.name)
                                                .foregroundColor(.black)
                                            
                                            Spacer()
                                        }
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 20)
                                        .frame(height: 60)
                                        
                                        Divider()
                                            .background(Color.gray.opacity(0.3))
                                            .padding(.leading, 52)
                                    }
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
    }
}
