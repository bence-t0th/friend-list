import SwiftUI
import MapKit

struct MainTabVew: View {
    @State private var viewModel: MainTabViewModel = MainTabViewModel()
    @State private var isDetailsPresented: Bool = false
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            MapView(
                users: viewModel.randomUsers,
                userPressed: { user in
                    viewModel.select(user)
                }
            )
            .tag(MainTabViewModel.TabSelection.map)
            
            ListView(
                users: viewModel.randomUsers,
                userPressed: { user in
                    viewModel.select(user)
                }
            )
            .tag(MainTabViewModel.TabSelection.list)
        }
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .bottomLeading) {
           bottomTab
        }
        .sheet(item: $viewModel.selectedUser) { user in
            DetailsView(user: user)
        }
        .overlay {
            searchBar
        }
    }
    
    private var bottomTab: some View {
        HStack {
            HStack {
                Button(action: { viewModel.selection = .map }) {
                    Image("map")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(viewModel.selection == .map ? .accent : .gray)
                        .padding(24)
                }
                
                Button(action: { viewModel.selection = .list }) {
                    Image("list")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(viewModel.selection == .list ? .accent : .gray)
                        .padding(24)
                }
            }
            .glassEffect()
            
            Spacer()
            
            Button(action: { viewModel.showSearch() }) {
                Text(viewModel.resultNumber.isEmpty ? "0" : viewModel.resultNumber)
                    .font(.title2)
                    .minimumScaleFactor(0.5)
                    .frame(width: 24, height: 24)
                    .padding(24)
            }
            .buttonStyle(.plain)
            .glassEffect()
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var searchBar: some View {
        if viewModel.searchVisible {
            HStack {
                TextField(
                    "No. of users",
                    text: $viewModel.resultNumber
                )
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                
                Button("", systemImage: "magnifyingglass") {
                    Task {
                        await viewModel.searchPressed()
                    }
                }
                .frame(width: 48, height: 48)
                .glassEffect()
            }
            .padding(32)
        }
    }
}

#Preview {
    MainTabVew()
}
