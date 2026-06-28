protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async -> Result<T, APIError>
}
