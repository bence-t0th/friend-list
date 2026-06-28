@testable import Friend_List

final class MockAPIClient: APIClientProtocol {
    var result: Result<RandomUserResponse, APIError>!

    func request<T: Decodable>(_ endpoint: Endpoint) async -> Result<T, APIError> {
        switch result! {
        case .success(let response):
            .success(response as! T)
        case .failure(let error):
            .failure(error)
        }
    }
}
