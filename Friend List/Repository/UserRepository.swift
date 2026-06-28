final class UserRepository: UserRepositoryProtocol {
    private let client: APIClientProtocol

    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }

    func fetchUser(results: Int) async -> Result<RandomUserResponse, APIError> {
        return await client.request(.randomUser(results: results))
    }
}
