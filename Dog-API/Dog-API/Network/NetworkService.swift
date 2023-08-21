import Foundation
import Alamofire

/// Service for all of the requests all of the requests for the D
public struct PetService {
    public let fetchList: (_ limit: Int, _ currentPage: Int) async throws -> Void
    public let fetchImage: (_ imageRef: String) async throws -> Void
}

extension PetService {
    public static func live(networkService: NetworkService) -> Self {
        return .init(
            fetchList: { limit, currentPage in
                let response: NetworkService.Response<[Dog]> = networkService.apiRequest(endpoint: .list(limit: limit, page: currentPage))
                
            },
            fetchImage: { imageRef in
                let respo
            
        })
    }
}

public struct NetworkService {
    private var call: (Endpoint) async throws -> Data
}

extension NetworkService {
    enum Error: Swift.Error {
        case invalidResponse
        case invalidURLError
    }
    
    public struct Response<T> {
        public let data: T
    }
}

extension NetworkService {
    public static func live(logger: LoggerService) -> Self {
        return .init(
            call: { endpoint in
                return try await withCheckedThrowingContinuation { continuation in
                    AF.request(
                        endpoint.requestPath,
                        method: endpoint.descriptor.method,
                        parameters: .buildParameters(queryItems: endpoint.parameters),
                        headers: endpoint.descriptor.basePath.header
                    ).responseData{ response in
                        switch response.result {
                        case let .success(data):
                            continuation.resume(returning: data)
                        case let .failure(error):
                            Task {
                                try await logger.log(error.localizedDescription, .error)
                            }
                            continuation.resume(throwing: error)
                        }
                    }
                    
                }
            })
    }
    
    public static func mock(response: @escaping () throws -> Data) -> Self {
        Self {_ in try response() }
    }
    
    public func apiRequest<T: Decodable>(
        endpoint: Endpoint,
        decoder: JSONDecoder = .init()
    ) async throws -> Response<T> {
        let data = try await call(endpoint)
        let decodedData = try decoder.decode(T.self, from: data)
        return Response(data: decodedData)
    }
}
