import Foundation

enum Endpoint {
    case randomUser(results: Int)
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "randomuser.me"
        components.path = "/api/"

        switch self {
        case .randomUser(let results):
            components.queryItems = [
                URLQueryItem(name: "results", value: String(results))
            ]
        }
        
        return components.url!
    }
}
