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
                                .tint(.white)
                                .scaleEffect(x: 1, y: 1.5, anchor: .center)
                            
                            Text("\(Int(taskList.progress * 100))% Complete")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.9))
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
                            withAnimation(.spring()) {
                                let translation = gesture.translation.width
                                if abs(translation) > 60 {
                                    offset = translation > 0 ? 100 : -100
                                } else {
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
