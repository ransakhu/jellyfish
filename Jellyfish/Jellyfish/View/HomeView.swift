
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = TaskListViewModel()
    @State private var showingArchive = false
    @State private var searchText = ""
    @State private var isSearching = false
    @FocusState private var searchFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                Color("backgroundColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Picker and Search button
                    HStack(spacing: 12) {
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
                                    .cornerRadius(31)
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
                                    .cornerRadius(31)
                            }
                        }
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 35)
                                .fill(Material.ultraThin)
                        )
                        
                        // Search button
                        Button {
                            isSearching.toggle()
                            if isSearching {
                                searchFieldFocused = true
                            }
                        } label: {
                            Image(systemName: isSearching ? "xmark" : "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(Color("listButton"))
                                .frame(width: 50, height: 50)
                                .background(
                                    Circle()
                                        .fill(Material.ultraThin)
                                )
                        }
                    }
                    .padding()
                    
                    // Search field
                    if isSearching {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search lists...", text: $searchText)
                                .focused($searchFieldFocused)
                                .accentColor(Color("listButton"))
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Material.ultraThin)
                        )
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    
                    // Lists with ScrollView
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            let lists = showingArchive ? viewModel.archivedLists : viewModel.activeLists
                            let filteredLists = searchText.isEmpty ? lists : lists.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                            
                            // Sort: incomplete lists first, completed lists last
                            let sortedLists = filteredLists.sorted { list1, list2 in
                                if list1.progress >= 1.0 && list2.progress < 1.0 {
                                    return false
                                } else if list1.progress < 1.0 && list2.progress >= 1.0 {
                                    return true
                                }
                                return false
                            }
                            
                            if sortedLists.isEmpty {
                                VStack(spacing: 12) {
                                    Image(systemName: showingArchive ? "archivebox" : "list.bullet")
                                        .font(.system(size: 60))
                                        .foregroundColor(.gray.opacity(0.5))
                                    Text(showingArchive ? "No archived lists" : searchText.isEmpty ? "No lists yet" : "No results found")
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                    Text(showingArchive ? "Swipe lists right to archive them" : searchText.isEmpty ? "Tap + to create your first list" : "Try a different search term")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(.top, 100)
                            } else {
                                ForEach(sortedLists) { list in
                                    TaskListCardView(
                                        taskList: list,
                                        viewModel: viewModel,
                                        isArchiveView: showingArchive
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 180)
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
                        
                        NavigationLink(destination: AddListView(viewModel: viewModel)) {
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
            .navigationBarHidden(true)
        }
    }
}

