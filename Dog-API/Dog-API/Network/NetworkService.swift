import Foundation
import Alamofire

/// Service for all of the requests all of the requests for the D
public struct PetService {
    public let fetchList: (_ limit: Int, _ currentPage: Int) async throws -> Void
    public let fetchImage: () async throws -> Void
}

extension PetService {
    public static func live() -> Self {
        
    }
}

typealias ResultClosure<T: Decodable>  = (Endpoint, T.Type) async throws -> Data

public struct NetworkService{
    public let call: ResultClosure

extension NetworkService {
    public static func live() -> Self {
        return .init(
            call: { endpoint, type in
                return try await withCheckedThrowingContinuation { continuation in
                    AF.request(
                        endpoint.requestPath,
                        method: endpoint.descriptor.method,
                        parameters: .buildParameters(queryItems: endpoint.parameters),
                        headers: endpoint.descriptor.basePath.header
                    )
                    .validate()
                    .responseDecodable(of: type)
                    { response in
                        switch response.result {
                        case let .success(data):
                            continuation.resume(returning: data)
                        case let .failure(error):
                            continuation.resume(throwing: error)
                        }
                    }
                }
            })
    }
    
}

//            request(_ convertible: URLConvertible,
//                              method: HTTPMethod = .get,
//                              parameters: Parameters? = nil,
//                              encoding: ParameterEncoding = URLEncoding.default,
//                              headers: HTTPHeaders? = nil,
//                              interceptor: RequestInterceptor? = nil,
//                              requestModifier: RequestModifier? = nil) -> DataRequest {
