import SwiftUI

struct AddTaskView: View {
    @ObservedObject var viewModel: TaskDetailViewModel
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
                            viewModel.addTask(name: taskName)
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
