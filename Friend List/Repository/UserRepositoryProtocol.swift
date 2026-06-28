protocol UserRepositoryProtocol {
    func fetchUser(results: Int) async -> Result<RandomUserResponse, APIError>
}
