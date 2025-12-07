//import SwiftUI
//
//struct HomeView: View {
//    @StateObject private var viewModel = TaskListViewModel()
//    @State private var showingArchive = false
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // Background color
//                Color("backgroundColor")
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 0) {
//                    // Custom Segmented control with glass effect
//                    HStack(spacing: 0) {
//                        Button {
//                            withAnimation(.easeInOut(duration: 0.2)) {
//                                showingArchive = false
//                            }
//                        } label: {
//                            Text("Lists")
//                                .fontWeight(.semibold)
//                                .foregroundColor(showingArchive ? Color("listButton") : .white)
//                                .frame(maxWidth: .infinity)
//                                .padding(.vertical, 10)
//                                .background(
//                                    Group {
//                                        if !showingArchive {
//                                            Color("listButton")
//                                        } else {
//                                            Color.clear
//                                        }
//                                    }
//                                )
//                                .cornerRadius(8)
//                        }
//                        
//                        Button {
//                            withAnimation(.easeInOut(duration: 0.2)) {
//                                showingArchive = true
//                            }
//                        } label: {
//                            Text("Archive")
//                                .fontWeight(.semibold)
//                                .foregroundColor(showingArchive ? .white : Color("listButton"))
//                                .frame(maxWidth: .infinity)
//                                .padding(.vertical, 10)
//                                .background(
//                                    Group {
//                                        if showingArchive {
//                                            Color("listButton")
//                                        } else {
//                                            Color.clear
//                                        }
//                                    }
//                                )
//                                .cornerRadius(8)
//                        }
//                    }
//                    .padding(4)
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(.ultraThinMaterial)
//                    )
//                    .padding()
//                    
//                    // Lists
//                    ScrollView {
//                        LazyVStack(spacing: 16) {
//                            let lists = showingArchive ? viewModel.archivedLists : viewModel.activeLists
//                            
//                            if lists.isEmpty {
//                                VStack(spacing: 12) {
//                                    Image(systemName: showingArchive ? "archivebox" : "list.bullet")
//                                        .font(.system(size: 60))
//                                        .foregroundColor(.gray.opacity(0.5))
//                                    Text(showingArchive ? "No archived lists" : "No lists yet")
//                                        .font(.headline)
//                                        .foregroundColor(.gray)
//                                    Text(showingArchive ? "Swipe lists right to archive them" : "Tap + to create your first list")
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
//                                        .multilineTextAlignment(.center)
//                                }
//                                .padding(.top, 100)
//                            } else {
//                                ForEach(lists) { list in
//                                    TaskListCardView(
//                                        taskList: list,
//                                        viewModel: viewModel,
//                                        isArchiveView: showingArchive
//                                    )
//                                }
//                            }
//                        }
//                        .padding()
//                        .padding(.bottom, 120) // Space for floating button
//                    }
//                }
//                
//                // Big floating plus button at bottom
//                VStack {
//                    Spacer()
//                    NavigationLink(destination: AddListView(viewModel: viewModel)) {
//                        Image(systemName: "plus.circle.fill")
//                            .font(.system(size: 80))
//                            .foregroundColor(Color("listButton"))
//                            .background(
//                                Circle()
//                                    .fill(Color.white)
//                                    .frame(width: 85, height: 85)
//                            )
//                    }
//                    .padding(.bottom, 50)
//                }
//            }
//            .navigationBarHidden(true)
//        }
//    }
//}



//v23
//import SwiftUI
//
//struct HomeView: View {
//    @StateObject private var viewModel = TaskListViewModel()
//    @State private var showingArchive = false
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // Background color
//                Color("backgroundColor")
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 0) {
//                    // Custom Segmented control with glass effect
//                    HStack(spacing: 0) {
//                        Button {
//                            withAnimation(.easeInOut(duration: 0.2)) {
//                                showingArchive = false
//                            }
//                        } label: {
//                            Text("Lists")
//                                .fontWeight(.semibold)
//                                .foregroundColor(showingArchive ? Color("listButton") : .white)
//                                .frame(maxWidth: .infinity)
//                                .padding(.vertical, 10)
//                                .background(
//                                    Group {
//                                        if !showingArchive {
//                                            Color("listButton")
//                                        } else {
//                                            Color.clear
//                                        }
//                                    }
//                                )
//                                .cornerRadius(8)
//                        }
//                        
//                        Button {
//                            withAnimation(.easeInOut(duration: 0.2)) {
//                                showingArchive = true
//                            }
//                        } label: {
//                            Text("Archive")
//                                .fontWeight(.semibold)
//                                .foregroundColor(showingArchive ? .white : Color("listButton"))
//                                .frame(maxWidth: .infinity)
//                                .padding(.vertical, 10)
//                                .background(
//                                    Group {
//                                        if showingArchive {
//                                            Color("listButton")
//                                        } else {
//                                            Color.clear
//                                        }
//                                    }
//                                )
//                                .cornerRadius(8)
//                        }
//                    }
//                    .padding(4)
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Material.ultraThin)
//                    )
//                    .padding()
//                    
//                    // Lists
//                    ScrollView {
//                        LazyVStack(spacing: 16) {
//                            let lists = showingArchive ? viewModel.archivedLists : viewModel.activeLists
//                            
//                            if lists.isEmpty {
//                                VStack(spacing: 12) {
//                                    Image(systemName: showingArchive ? "archivebox" : "list.bullet")
//                                        .font(.system(size: 60))
//                                        .foregroundColor(.gray.opacity(0.5))
//                                    Text(showingArchive ? "No archived lists" : "No lists yet")
//                                        .font(.headline)
//                                        .foregroundColor(.gray)
//                                    Text(showingArchive ? "Swipe lists right to archive them" : "Tap + to create your first list")
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
//                                        .multilineTextAlignment(.center)
//                                }
//                                .padding(.top, 100)
//                            } else {
//                                ForEach(lists) { list in
//                                    TaskListCardView(
//                                        taskList: list,
//                                        viewModel: viewModel,
//                                        isArchiveView: showingArchive
//                                    )
//                                }
//                            }
//                        }
//                        .padding()
//                        .padding(.bottom, 120) // Space for floating button
//                    }
//                }
//                
//                // Big floating plus button at bottom - glassy
//                VStack {
//                    Spacer()
//                    
//                    ZStack {
//                        Circle()
//                            .fill(Material.ultraThin)
//                            .frame(width: 85, height: 85)
//                        
//                        NavigationLink(destination: AddListView(viewModel: viewModel)) {
//                            Image(systemName: "plus.circle.fill")
//                                .font(.system(size: 80))
//                                .foregroundColor(Color("listButton"))
//                        }
//                    }
//                    .padding(.bottom, 50)
//                }
//            }
//            .navigationBarHidden(true)
//        }
//    }
//}


//MARK: v24 THE BEST SO FAR

//import SwiftUI
//
//struct HomeView: View {
//    @StateObject private var viewModel = TaskListViewModel()
//    @State private var showingArchive = false
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // Background color
//                Color("backgroundColor")
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 0) {
//                    // Picker and Search button
//                    HStack(spacing: 12) {
//                        // Custom Segmented control with glass effect
//                        HStack(spacing: 0) {
//                            Button {
//                                withAnimation(.easeInOut(duration: 0.2)) {
//                                    showingArchive = false
//                                }
//                            } label: {
//                                Text("Lists")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(showingArchive ? Color("listButton") : .white)
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.vertical, 10)
//                                    .background(
//                                        Group {
//                                            if !showingArchive {
//                                                Color("listButton")
//                                            } else {
//                                                Color.clear
//                                            }
//                                        }
//                                    )
//                                    .cornerRadius(31)
//                            }
//                            
//                            Button {
//                                withAnimation(.easeInOut(duration: 0.2)) {
//                                    showingArchive = true
//                                }
//                            } label: {
//                                Text("Archive")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(showingArchive ? .white : Color("listButton"))
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.vertical, 10)
//                                    .background(
//                                        Group {
//                                            if showingArchive {
//                                                Color("listButton")
//                                            } else {
//                                                Color.clear
//                                            }
//                                        }
//                                    )
//                                    .cornerRadius(31)
//                            }
//                        }
//                        .padding(4)
//                        .background(
//                            RoundedRectangle(cornerRadius: 35)
//                                .fill(Material.ultraThin)
//                        )
//                        
//                        // Search button
//                        Button {
//                            // Search action
//                        } label: {
//                            Image(systemName: "magnifyingglass")
//                                .font(.title2)
//                                .foregroundColor(Color("listButton"))
//                                .frame(width: 50, height: 50)
//                                .background(
//                                    Circle()
//                                        .fill(Material.ultraThin)
//                                )
//                        }
//                    }
//                    .padding()
//                    
//                    // Lists
//                    ScrollView {
//                        LazyVStack(spacing: 16) {
//                            let lists = showingArchive ? viewModel.archivedLists : viewModel.activeLists
//                            
//                            if lists.isEmpty {
//                                VStack(spacing: 12) {
//                                    Image(systemName: showingArchive ? "archivebox" : "list.bullet")
//                                        .font(.system(size: 60))
//                                        .foregroundColor(.gray.opacity(0.5))
//                                    Text(showingArchive ? "No archived lists" : "No lists yet")
//                                        .font(.headline)
//                                        .foregroundColor(.gray)
//                                    Text(showingArchive ? "Swipe lists right to archive them" : "Tap + to create your first list")
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
//                                        .multilineTextAlignment(.center)
//                                }
//                                .padding(.top, 100)
//                            } else {
//                                ForEach(lists) { list in
//                                    TaskListCardView(
//                                        taskList: list,
//                                        viewModel: viewModel,
//                                        isArchiveView: showingArchive
//                                    )
//                                }
//                            }
//                        }
//                        .padding()
//                        .padding(.bottom, 120) // Space for floating button
//                    }
//                }
//                
//                // Big floating plus button at bottom - glassy
//                VStack {
//                    Spacer()
//                    
//                    ZStack {
//                        Circle()
//                            .fill(Material.ultraThin)
//                            .frame(width: 85, height: 85)
//                        
//                        NavigationLink(destination: AddListView(viewModel: viewModel)) {
//                            Image(systemName: "plus.circle.fill")
//                                .font(.system(size: 80))
//                                .foregroundColor(Color("listButton"))
//                        }
//                    }
//                    .padding(.bottom, 50)
//                }
//            }
//            .navigationBarHidden(true)
//        }
//    }
//}
//



// MARK: CHAT
//import SwiftUI
//
//struct HomeView: View {
//    @StateObject private var viewModel = TaskListViewModel()
//    @State private var showingArchive = false
//    
//    // Search state
//    @State private var isSearching = false
//    @State private var searchText = ""
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // Background color
//                Color("backgroundColor")
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 0) {
//                    
//                    // MARK: - Top controls (Lists/Archive + Search)
//                    HStack(spacing: 12) {
//                        // Custom segmented control
//                        HStack(spacing: 0) {
//                            Button {
//                                withAnimation(.easeInOut(duration: 0.2)) {
//                                    showingArchive = false
//                                }
//                            } label: {
//                                Text("Lists")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(showingArchive ? Color("listButton") : .white)
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.vertical, 10)
//                                    .background(
//                                        Group {
//                                            if !showingArchive {
//                                                Color("listButton")
//                                            } else {
//                                                Color.clear
//                                            }
//                                        }
//                                    )
//                                    .cornerRadius(31)
//                            }
//                            
//                            Button {
//                                withAnimation(.easeInOut(duration: 0.2)) {
//                                    showingArchive = true
//                                }
//                            } label: {
//                                Text("Archive")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(showingArchive ? .white : Color("listButton"))
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.vertical, 10)
//                                    .background(
//                                        Group {
//                                            if showingArchive {
//                                                Color("listButton")
//                                            } else {
//                                                Color.clear
//                                            }
//                                        }
//                                    )
//                                    .cornerRadius(31)
//                            }
//                        }
//                        .padding(4)
//                        .background(
//                            RoundedRectangle(cornerRadius: 35)
//                                .fill(Material.ultraThin)
//                        )
//                        
//                        // Search button
//                        Button {
//                            withAnimation {
//                                isSearching.toggle()
//                                if !isSearching {
//                                    searchText = ""
//                                }
//                            }
//                        } label: {
//                            Image(systemName: "magnifyingglass")
//                                .font(.title2)
//                                .foregroundColor(Color("listButton"))
//                                .frame(width: 50, height: 50)
//                                .background(
//                                    Circle()
//                                        .fill(Material.ultraThin)
//                                )
//                        }
//                    }
//                    .padding(.horizontal)
//                    .padding(.top)
//                    
//                    // Search field (appears when search is active)
//                    if isSearching {
//                        TextField("Search lists", text: $searchText)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .padding(.horizontal)
//                            .padding(.bottom, 4)
//                    }
//                    
//                    // MARK: - Lists
//                    ScrollView {
//                        LazyVStack(spacing: 16) {
//                            // Base data: active or archived
//                            let baseLists = showingArchive ? viewModel.archivedLists : viewModel.activeLists
//                            
//                            // Filter by search text
//                            let lists = baseLists.filter { list in
//                                guard !searchText.isEmpty else { return true }
//                                return list.name.localizedCaseInsensitiveContains(searchText)
//                            }
//                            
//                            if lists.isEmpty {
//                                VStack(spacing: 12) {
//                                    Image(systemName: showingArchive ? "archivebox" : "list.bullet")
//                                        .font(.system(size: 60))
//                                        .foregroundColor(.gray.opacity(0.5))
//                                    
//                                    Text(showingArchive ? "No archived lists" : "No lists yet")
//                                        .font(.headline)
//                                        .foregroundColor(.gray)
//                                    
//                                    Text(showingArchive
//                                         ? "Swipe lists right to archive them"
//                                         : "Tap + to create your first list")
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
//                                        .multilineTextAlignment(.center)
//                                }
//                                .padding(.top, 100)
//                            } else {
//                                ForEach(lists) { list in
//                                    TaskListCardView(
//                                        taskList: list,
//                                        viewModel: viewModel,
//                                        isArchiveView: showingArchive
//                                    )
//                                }
//                            }
//                        }
//                        .padding()
//                        .padding(.bottom, 120) // Space for floating button
//                    }
//                }
//                
//                // MARK: - Floating + button
//                VStack {
//                    Spacer()
//                    
//                    ZStack {
//                        Circle()
//                            .fill(Material.ultraThin)
//                            .frame(width: 85, height: 85)
//                        
//                        NavigationLink(destination: AddListView(viewModel: viewModel)) {
//                            Image(systemName: "plus.circle.fill")
//                                .font(.system(size: 80))
//                                .foregroundColor(Color("listButton"))
//                        }
//                    }
//                    .padding(.bottom, 50)
//                }
//            }
//            .navigationBarHidden(true)
//        }
//    }
//}


// MARK: v32

//import SwiftUI
//
//struct HomeView: View {
//    @StateObject private var viewModel = TaskListViewModel()
//    @State private var showingArchive = false
//    @State private var searchText = ""
//    @State private var isSearching = false
//    @FocusState private var searchFieldFocused: Bool
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // Background color
//                Color("backgroundColor")
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 0) {
//                    // Picker and Search button
//                    HStack(spacing: 12) {
//                        // Custom Segmented control with glass effect
//                        HStack(spacing: 0) {
//                            Button {
//                                withAnimation(.easeInOut(duration: 0.2)) {
//                                    showingArchive = false
//                                }
//                            } label: {
//                                Text("Lists")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(showingArchive ? Color("listButton") : .white)
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.vertical, 10)
//                                    .background(
//                                        Group {
//                                            if !showingArchive {
//                                                Color("listButton")
//                                            } else {
//                                                Color.clear
//                                            }
//                                        }
//                                    )
//                                    .cornerRadius(31)
//                            }
//                            
//                            Button {
//                                withAnimation(.easeInOut(duration: 0.2)) {
//                                    showingArchive = true
//                                }
//                            } label: {
//                                Text("Archive")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(showingArchive ? .white : Color("listButton"))
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.vertical, 10)
//                                    .background(
//                                        Group {
//                                            if showingArchive {
//                                                Color("listButton")
//                                            } else {
//                                                Color.clear
//                                            }
//                                        }
//                                    )
//                                    .cornerRadius(31)
//                            }
//                        }
//                        .padding(4)
//                        .background(
//                            RoundedRectangle(cornerRadius: 35)
//                                .fill(Material.ultraThin)
//                        )
//                        
//                        // Search button
//                        Button {
//                            isSearching.toggle()
//                            if isSearching {
//                                searchFieldFocused = true
//                            }
//                        } label: {
//                            Image(systemName: isSearching ? "xmark" : "magnifyingglass")
//                                .font(.title2)
//                                .foregroundColor(Color("listButton"))
//                                .frame(width: 50, height: 50)
//                                .background(
//                                    Circle()
//                                        .fill(Material.ultraThin)
//                                )
//                        }
//                    }
//                    .padding()
//                    
//                    // Search field
//                    if isSearching {
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(.gray)
//                            TextField("Search lists...", text: $searchText)
//                                .focused($searchFieldFocused)
//                        }
//                        .padding()
//                        .background(
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Material.ultraThin)
//                        )
//                        .padding(.horizontal)
//                        .transition(.move(edge: .top).combined(with: .opacity))
//                    }
//                    
//                    // Lists
//                    ScrollView {
//                        LazyVStack(spacing: 16) {
//                            let lists = showingArchive ? viewModel.archivedLists : viewModel.activeLists
//                            let filteredLists = searchText.isEmpty ? lists : lists.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
//                            
//                            if filteredLists.isEmpty {
//                                VStack(spacing: 12) {
//                                    Image(systemName: showingArchive ? "archivebox" : "list.bullet")
//                                        .font(.system(size: 60))
//                                        .foregroundColor(.gray.opacity(0.5))
//                                    Text(showingArchive ? "No archived lists" : searchText.isEmpty ? "No lists yet" : "No results found")
//                                        .font(.headline)
//                                        .foregroundColor(.gray)
//                                    Text(showingArchive ? "Swipe lists right to archive them" : searchText.isEmpty ? "Tap + to create your first list" : "Try a different search term")
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
//                                        .multilineTextAlignment(.center)
//                                }
//                                .padding(.top, 100)
//                            } else {
//                                ForEach(filteredLists) { list in
//                                    TaskListCardView(
//                                        taskList: list,
//                                        viewModel: viewModel,
//                                        isArchiveView: showingArchive
//                                    )
//                                }
//                            }
//                        }
//                        .padding()
//                        .padding(.bottom, 120) // Space for floating button
//                    }
//                }
//                
//                // Big floating plus button at bottom - glassy
//                VStack {
//                    Spacer()
//                    
//                    ZStack {
//                        Circle()
//                            .fill(Material.ultraThin)
//                            .frame(width: 85, height: 85)
//                        
//                        Button {
//                            viewModel.showingAddList = true
//                        } label: {
//                            Image(systemName: "plus.circle.fill")
//                                .font(.system(size: 80))
//                                .foregroundColor(Color("listButton"))
//                        }
//                    }
//                    .padding(.bottom, 50)
//                }
//            }
//            .navigationBarHidden(true)
//            .sheet(isPresented: $viewModel.showingAddList) {
//                AddListView(viewModel: viewModel)
//            }
//        }
//    }
//}



// MARK: V34 best2
//import SwiftUI
//
//struct HomeView: View {
//    @StateObject private var viewModel = TaskListViewModel()
//    @State private var showingArchive = false
//    @State private var searchText = ""
//    @State private var isSearching = false
//    @FocusState private var searchFieldFocused: Bool
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // Background color
//                Color("backgroundColor")
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 0) {
//                    // Picker and Search button
//                    HStack(spacing: 12) {
//                        // Custom Segmented control with glass effect
//                        HStack(spacing: 0) {
//                            Button {
//                                withAnimation(.easeInOut(duration: 0.2)) {
//                                    showingArchive = false
//                                }
//                            } label: {
//                                Text("Lists")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(showingArchive ? Color("listButton") : .white)
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.vertical, 10)
//                                    .background(
//                                        Group {
//                                            if !showingArchive {
//                                                Color("listButton")
//                                            } else {
//                                                Color.clear
//                                            }
//                                        }
//                                    )
//                                    .cornerRadius(31)
//                            }
//                            
//                            Button {
//                                withAnimation(.easeInOut(duration: 0.2)) {
//                                    showingArchive = true
//                                }
//                            } label: {
//                                Text("Archive")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(showingArchive ? .white : Color("listButton"))
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.vertical, 10)
//                                    .background(
//                                        Group {
//                                            if showingArchive {
//                                                Color("listButton")
//                                            } else {
//                                                Color.clear
//                                            }
//                                        }
//                                    )
//                                    .cornerRadius(31)
//                            }
//                        }
//                        .padding(4)
//                        .background(
//                            RoundedRectangle(cornerRadius: 35)
//                                .fill(Material.ultraThin)
//                        )
//                        
//                        // Search button
//                        Button {
//                            isSearching.toggle()
//                            if isSearching {
//                                searchFieldFocused = true
//                            }
//                        } label: {
//                            Image(systemName: isSearching ? "xmark" : "magnifyingglass")
//                                .font(.title2)
//                                .foregroundColor(Color("listButton"))
//                                .frame(width: 50, height: 50)
//                                .background(
//                                    Circle()
//                                        .fill(Material.ultraThin)
//                                )
//                        }
//                    }
//                    .padding()
//                    
//                    // Search field
//                    if isSearching {
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(.gray)
//                            TextField("Search lists...", text: $searchText)
//                                .focused($searchFieldFocused)
//                        }
//                        .padding()
//                        .background(
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Material.ultraThin)
//                        )
//                        .padding(.horizontal)
//                        .transition(.move(edge: .top).combined(with: .opacity))
//                    }
//                    
//                    // Lists
//                    ScrollView {
//                        LazyVStack(spacing: 16) {
//                            let lists = showingArchive ? viewModel.archivedLists : viewModel.activeLists
//                            let filteredLists = searchText.isEmpty ? lists : lists.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
//                            
//                            if filteredLists.isEmpty {
//                                VStack(spacing: 12) {
//                                    Image(systemName: showingArchive ? "archivebox" : "list.bullet")
//                                        .font(.system(size: 60))
//                                        .foregroundColor(.gray.opacity(0.5))
//                                    Text(showingArchive ? "No archived lists" : searchText.isEmpty ? "No lists yet" : "No results found")
//                                        .font(.headline)
//                                        .foregroundColor(.gray)
//                                    Text(showingArchive ? "Swipe lists right to archive them" : searchText.isEmpty ? "Tap + to create your first list" : "Try a different search term")
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
//                                        .multilineTextAlignment(.center)
//                                }
//                                .padding(.top, 100)
//                            } else {
//                                ForEach(filteredLists) { list in
//                                    TaskListCardView(
//                                        taskList: list,
//                                        viewModel: viewModel,
//                                        isArchiveView: showingArchive
//                                    )
//                                }
//                            }
//                        }
//                        .padding()
//                        .padding(.bottom, 120) // Space for floating button
//                    }
//                }
//                
//                // Big floating plus button at bottom - glassy
//                VStack {
//                    Spacer()
//                    
//                    NavigationLink(destination: AddListView(viewModel: viewModel)) {
//                        ZStack {
//                            Circle()
//                                .fill(Material.ultraThin)
//                                .frame(width: 85, height: 85)
//                            
//                            Image(systemName: "plus.circle.fill")
//                                .font(.system(size: 80))
//                                .foregroundColor(Color("listButton"))
//                        }
//                    }
//                    .padding(.bottom, 50)
//                }
//            }
//            .navigationBarHidden(true)
//        }
//    }
//}
//
//


// MARK: V1 only blur
//import SwiftUI
//
//struct HomeView: View {
//    @StateObject private var viewModel = TaskListViewModel()
//    @State private var showingArchive = false
//    @State private var searchText = ""
//    @State private var isSearching = false
//    @FocusState private var searchFieldFocused: Bool
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // Background color
//                Color("backgroundColor")
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 0) {
//                    // Picker and Search button
//                    HStack(spacing: 12) {
//                        // Custom Segmented control with glass effect
//                        HStack(spacing: 0) {
//                            Button {
//                                withAnimation(.easeInOut(duration: 0.2)) {
//                                    showingArchive = false
//                                }
//                            } label: {
//                                Text("Lists")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(showingArchive ? Color("listButton") : .white)
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.vertical, 10)
//                                    .background(
//                                        Group {
//                                            if !showingArchive {
//                                                Color("listButton")
//                                            } else {
//                                                Color.clear
//                                            }
//                                        }
//                                    )
//                                    .cornerRadius(31)
//                            }
//                            
//                            Button {
//                                withAnimation(.easeInOut(duration: 0.2)) {
//                                    showingArchive = true
//                                }
//                            } label: {
//                                Text("Archive")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(showingArchive ? .white : Color("listButton"))
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.vertical, 10)
//                                    .background(
//                                        Group {
//                                            if showingArchive {
//                                                Color("listButton")
//                                            } else {
//                                                Color.clear
//                                            }
//                                        }
//                                    )
//                                    .cornerRadius(31)
//                            }
//                        }
//                        .padding(4)
//                        .background(
//                            RoundedRectangle(cornerRadius: 35)
//                                .fill(Material.ultraThin)
//                        )
//                        
//                        // Search button
//                        Button {
//                            isSearching.toggle()
//                            if isSearching {
//                                searchFieldFocused = true
//                            }
//                        } label: {
//                            Image(systemName: isSearching ? "xmark" : "magnifyingglass")
//                                .font(.title2)
//                                .foregroundColor(Color("listButton"))
//                                .frame(width: 50, height: 50)
//                                .background(
//                                    Circle()
//                                        .fill(Material.ultraThin)
//                                )
//                        }
//                    }
//                    .padding()
//                    
//                    // Search field
//                    if isSearching {
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(.gray)
//                            TextField("Search lists...", text: $searchText)
//                                .focused($searchFieldFocused)
//                        }
//                        .padding()
//                        .background(
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Material.ultraThin)
//                        )
//                        .padding(.horizontal)
//                        .transition(.move(edge: .top).combined(with: .opacity))
//                    }
//                    
//                    // Lists
//                    ScrollView {
//                        LazyVStack(spacing: 16) {
//                            let lists = showingArchive ? viewModel.archivedLists : viewModel.activeLists
//                            let filteredLists = searchText.isEmpty ? lists : lists.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
//                            
//                            if filteredLists.isEmpty {
//                                VStack(spacing: 12) {
//                                    Image(systemName: showingArchive ? "archivebox" : "list.bullet")
//                                        .font(.system(size: 60))
//                                        .foregroundColor(.gray.opacity(0.5))
//                                    Text(showingArchive ? "No archived lists" : searchText.isEmpty ? "No lists yet" : "No results found")
//                                        .font(.headline)
//                                        .foregroundColor(.gray)
//                                    Text(showingArchive ? "Swipe lists right to archive them" : searchText.isEmpty ? "Tap + to create your first list" : "Try a different search term")
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
//                                        .multilineTextAlignment(.center)
//                                }
//                                .padding(.top, 100)
//                            } else {
//                                ForEach(filteredLists) { list in
//                                    TaskListCardView(
//                                        taskList: list,
//                                        viewModel: viewModel,
//                                        isArchiveView: showingArchive
//                                    )
//                                }
//                            }
//                        }
//                        .padding(.horizontal)
//                        .padding(.bottom, 200) // Increased space for floating button
//                    }
//                }
//                
//                // Big floating plus button at bottom with blur
//                VStack {
//                    Spacer()
//                    
//                    // Blur effect behind button
//                    Rectangle()
//                        .fill(.ultraThinMaterial)
//                        .frame(height: 200)
//                        .mask(
//                            LinearGradient(
//                                gradient: Gradient(colors: [.clear, .white]),
//                                startPoint: .top,
//                                endPoint: .bottom
//                            )
//                        )
//                        .overlay(
//                          
//                            // Plus button
//                            NavigationLink(destination: AddListView(viewModel: viewModel)) {
//                                ZStack {
//                                    Circle()
//                                        .fill(Color(red: 38/255, green: 38/255, blue: 80/255))
//                                        .frame(width: 80, height: 80)
//                                    
//                                    Image(systemName: "plus")
//                                        .font(.system(size: 40, weight: .semibold))
//                                        .foregroundColor(Color("backgroundColor"))
//                                }
//                            }
//                            .padding(.bottom, 35)
//                        )
//                }
//                .ignoresSafeArea(edges: .bottom)
//            }
//            .navigationBarHidden(true)
//        }
//    }
//}


//MARK: v2 D
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
                            
                            if filteredLists.isEmpty {
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
                                ForEach(filteredLists) { list in
                                    TaskListCardView(
                                        taskList: list,
                                        viewModel: viewModel,
                                        isArchiveView: showingArchive
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 180) // Space for blur and button
                    }
                    
                    Spacer()
                }
                
                // Blur effect and button at bottom
                VStack {
                    Spacer()
                    
                    ZStack(alignment: .bottom) {
                        // Blur background
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(height: 200)
                            .mask(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: .clear, location: 0),
                                        .init(color: .white, location: 0.7),
                                        .init(color: .white, location: 0.7)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        
                        // Plus button
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
