import Foundation

/// Service for all of the requests all of the requests for the D
public struct PetService {
    public var fetchList:  @Sendable (_ limit: Int, _ currentPage: Int) async throws -> [Dog]
    public var fetchImage:  @Sendable (_ imageRef: String) async throws -> URL
}

extension PetService {
    public static func live(networkService: NetworkService) -> Self {
        return .init(
            fetchList: { limit, currentPage in
                let response: NetworkService.Response<[Dog]> = try await networkService.apiRequest(endpoint: .list(limit: limit, page: currentPage))
                return response.data
            },
            fetchImage: { imageRef in
                let response: NetworkService.Response<URL> = try await networkService.apiRequest(endpoint: .image(id: imageRef))
                return response.data
        })
    }
}
