import SwiftUI

struct AddListView: View {
    @ObservedObject var viewModel: TaskListViewModel
    @State private var listName = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                Text("List Name")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                
                TextField("Enter list name", text: $listName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.body)
                
                Spacer()
            }
            .padding()
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
                    if !listName.trimmingCharacters(in: .whitespaces).isEmpty {
                        viewModel.addTaskList(name: listName)
                        dismiss()
                    }
                }
                .fontWeight(.semibold)
                .foregroundColor(Color("listButton"))
                .disabled(listName.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
    }
}
