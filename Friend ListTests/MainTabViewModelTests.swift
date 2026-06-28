import Testing
internal import Foundation
@testable import Friend_List

@Suite
struct MainTabViewModelTests {
    let repository = MockUserRepository()
    
    @Test(arguments: [User.mock])
    func selectUser(user: User) {
        let viewModel = MainTabViewModel(repository: repository)
        viewModel.select(user)
        
        #expect(viewModel.selectedUser != nil)
        #expect(viewModel.selectedUser == user)
    }
    
    @Test
    func showSearch() {
        let viewModel = MainTabViewModel(repository: repository)
        viewModel.showSearch()
        #expect(viewModel.searchVisible)
    }
    
    @Test @MainActor
    func searchPressed() async {
        repository.result = .success(
            RandomUserResponse(
                results: Array(repeating: .mock, count: 32),
                info: Info(
                    seed: "",
                    results: 32,
                    page: 1,
                    version: ""
                )
            )
        )
        let viewModel = MainTabViewModel(repository: repository)
        viewModel.resultNumber = "32"
        await viewModel.searchPressed()
        #expect(!viewModel.searchVisible)
        #expect(!viewModel.resultNumber.isEmpty)
    }
    
    @Test(arguments: ["1", "10"]) @MainActor
    func fetchUsers(resultNumber: String) async {
        repository.result = .success(
            RandomUserResponse(
                results: Array(repeating: .mock, count: Int(resultNumber) ?? 0),
                info: Info(
                    seed: "",
                    results: Int(resultNumber) ?? 0,
                    page: 1,
                    version: ""
                )
            )
        )
        let viewModel = MainTabViewModel(repository: repository)
        viewModel.resultNumber = resultNumber
        await viewModel.searchPressed()
        
        #expect(!viewModel.searchVisible)
        #expect(!viewModel.resultNumber.isEmpty)
        
        #expect(!viewModel.randomUsers.isEmpty)
        #expect(viewModel.randomUsers.count == Int(resultNumber) ?? 0)
    }
}
