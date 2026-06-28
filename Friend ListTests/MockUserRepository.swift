@testable import Friend_List

final class MockUserRepository: UserRepositoryProtocol {
    var result: Result<RandomUserResponse, APIError>!

    func fetchUser(results: Int) async -> Result<RandomUserResponse, APIError> {
        result
    }
}
