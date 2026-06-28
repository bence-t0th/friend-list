import Foundation

@Observable
class MainTabViewModel {
    enum TabSelection: Hashable {
        case map, list, search
    }
    
    var selection: TabSelection = .map
    var selectedUser: User?
    private(set) var randomUsers: [User] = []
    private(set) var searchVisible: Bool = false
    var resultNumber: String = ""
    
    private let repository: UserRepositoryProtocol
    
    init(
        repository: UserRepositoryProtocol = UserRepository()
    ) {
        self.repository = repository
    }
    
    func select(_ user: User) {
        selectedUser = user
    }
    
    func showSearch() {
        searchVisible = true
    }
    
    func searchPressed() async {
        searchVisible = false
        
        switch await repository.fetchUser(results: Int(resultNumber) ?? 0) {
        case let .success(response):
            print(response)
            self.randomUsers = response.results
        case let .failure(error):
            print(error.localizedDescription)
        }
    }
}
