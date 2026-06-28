import Foundation

struct User: Codable, Sendable, Hashable, Identifiable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: DateInfo
    let registered: DateInfo
    let phone: String
    let cell: String
    let id: ID
    let picture: Picture
    let nat: String
}

struct Name: Codable, Sendable, Hashable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable, Sendable, Hashable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Postcode
    let coordinates: Coordinates
    let timezone: Timezone
}

struct Street: Codable, Sendable, Hashable {
    let number: Int
    let name: String
}

enum Postcode: Codable, Sendable, Hashable {
    case int(Int)
    case string(String)
    
    var description: String {
        switch self {
        case .int(let value):
            return String(value)
        case .string(let value):
            return value
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else {
            self = .string(try container.decode(String.self))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        }
    }
}

struct Coordinates: Codable, Sendable, Hashable {
    let latitude: String
    let longitude: String
}

struct Timezone: Codable, Sendable, Hashable {
    let offset: String
    let description: String
}

struct Login: Codable, Sendable, Hashable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

struct DateInfo: Codable, Sendable, Hashable {
    let date: Date
    let age: Int
}

struct ID: Codable, Sendable, Hashable {
    let name: String
    let value: String?
}

struct Picture: Codable, Sendable, Hashable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct Info: Codable, Sendable, Hashable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}
