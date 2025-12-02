import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = TaskListViewModel()
    @State private var showingArchive = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                Color("backgroundColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Custom Segmented control with glass effect
                    HStack(spacing: 0) {
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showingArchive = false
                            }
                        } label: {
                            Text("Lists")
                                .fontWeight(.semibold)
                                .foregroundColor(showingArchive ? Color("listButton") : .white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(
                                    Group {
                                        if !showingArchive {
                                            Color("listButton")
                                        } else {
                                            Color.clear
                                        }
                                    }
                                )
                                .cornerRadius(8)
                        }
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showingArchive = true
                            }
                        } label: {
                            Text("Archive")
                                .fontWeight(.semibold)
                                .foregroundColor(showingArchive ? .white : Color("listButton"))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(
                                    Group {
                                        if showingArchive {
                                            Color("listButton")
                                        } else {
                                            Color.clear
                                        }
                                    }
                                )
                                .cornerRadius(8)
                        }
                    }
                    .padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.ultraThinMaterial)
                    )
                    .padding()
                    
                    // Lists
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            let lists = showingArchive ? viewModel.archivedLists : viewModel.activeLists
                            
                            if lists.isEmpty {
                                VStack(spacing: 12) {
                                    Image(systemName: showingArchive ? "archivebox" : "list.bullet")
                                        .font(.system(size: 60))
                                        .foregroundColor(.gray.opacity(0.5))
                                    Text(showingArchive ? "No archived lists" : "No lists yet")
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                    Text(showingArchive ? "Swipe lists right to archive them" : "Tap + to create your first list")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(.top, 100)
                            } else {
                                ForEach(lists) { list in
                                    TaskListCardView(
                                        taskList: list,
                                        viewModel: viewModel,
                                        isArchiveView: showingArchive
                                    )
                                }
                            }
                        }
                        .padding()
                        .padding(.bottom, 120) // Space for floating button
                    }
                }
                
                // Big floating plus button at bottom
                VStack {
                    Spacer()
                    NavigationLink(destination: AddListView(viewModel: viewModel)) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(Color("listButton"))
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 85, height: 85)
                            )
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationBarHidden(true)
        }
    }
}
