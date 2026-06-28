import Testing
internal import Foundation
@testable import Friend_List

@Suite(.serialized)
struct UserRepositoryTests {
    let client = MockAPIClient()
    
    @Test
    func fetchUserSuccess() async throws {
        client.result = await .success(
            RandomUserResponse(
                results: [.mock],
                info: .init(
                    seed: "",
                    results: 1,
                    page: 1,
                    version: "")
            )
        )
        
        let repository = await UserRepository(client: client)
        switch await repository.fetchUser(results: 1) {
        case let .success(response):
            #expect(response.results.count == 1)
            #expect(response.results.first == .mock)
        case .failure:
            Issue.record("Expected success.")
        }
    }
    
    @Test
    func fetchUserError() async throws {
        client.result = .failure(.invalidURL)
        
        let repository = await UserRepository(client: client)
        switch await repository.fetchUser(results: 1) {
        case .success:
            Issue.record("Expected failure.")
        case let .failure(error):
            #expect(error.localizedDescription == APIError.invalidURL.localizedDescription)
        }
    }
}
