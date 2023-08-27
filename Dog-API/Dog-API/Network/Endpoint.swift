import Foundation
import Alamofire

enum APIVersion: String {
    case v1
}

enum BasePath: String {
    case dogs = "https://api.thedogapi.com"

    var header: HTTPHeaders {
        var headers: HTTPHeaders = [.accept("application/json")]
        
        guard let authToken = ProcessInfo.processInfo.environment["API_KEY"] else {
            return headers
        }

        headers.add(.authorization(bearerToken: authToken))
        return headers
    }
}

/// Struct to join everything related to URL to do the request later with version of strand and type of http request
struct EndpointDescriptor {
    let basePath: BasePath
    let version: APIVersion
    let method: HTTPMethod
    
    init(basePath: BasePath, version: APIVersion = .v1, method: HTTPMethod = .get) {
        self.basePath = basePath
        self.version = version
        self.method = method
    }
}

public enum Endpoint: Equatable {
    case list(limit: Int, page: Int)
    case image(id: String)
    
    var name: String {
        switch self {
        case .list:
            return "breeds"
        case .image(let id):
            return "images/\(id)"
        }
    }
    
    // All parameters after the base url, will all be concatenated with &
    // And the API Query Item begins with ? on the request header
    var parameters: [APIQueryItem] {
        switch self {
        case .list(let limit, let page):
            return [
                .keyValue(key: "limit", value: "\(limit)"),
                .keyValue(key: "page", value: "\(page)")
            ]
        default:
            return []
        }
    }
    
    // Descriptor that returns everything related to the base URL
    var descriptor: EndpointDescriptor {
        switch self {
        case .list, .image:
            return  .init(basePath: .dogs)
        }
    }
    
    var requestPath: String {
        return "\(self.descriptor.basePath)/\(self.descriptor.version)/\(self.name)"
    }
}

// Can add more specific query items here if needed e.g: language, utc, etc
enum APIQueryItem {
    case keyValue(key: String, value: String) // to set key = value on URL
}

// TODO: Add this extension to Alamofire Helper Request File
// Simple Extension to convert the API Query Items to the parameters to just pass it more easily
extension Alamofire.Parameters {
    static func buildParameters(queryItems: [APIQueryItem]) -> Self {
        var dictionary: Self = [:]
        
        for item in queryItems {
            switch item {
            case .keyValue(let key, let value):
                dictionary[key] = value
            }
        }
        
        return dictionary
    }
}
