import Foundation

final class APIClient: APIClientProtocol, Sendable {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async -> Result<T, APIError> {
        do {
            let (data, response) = try await session.data(from: endpoint.url)
            
            guard let http = response as? HTTPURLResponse else {
                return .failure(.badResponse(statusCode: -1))
            }
            
            guard (200..<300).contains(http.statusCode) else {
                return .failure(.badResponse(statusCode: http.statusCode))
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let decoded = try decoder.decode(T.self, from: data)
                return .success(decoded)
            } catch {
                return .failure(.unknown(error))
            }
        } catch {
            return .failure(.unknown(error))
        }
    }
}
