import Dependencies

extension NetworkService: DependencyKey {
    @Dependency(\.loggerService) private static var loggerService
    public static let liveValue: NetworkService = .live(
        logger: loggerService
    )
}

extension DependencyValues {
    public var networkService: NetworkService {
        get { self[NetworkService.self] }
        set { self[NetworkService.self] = newValue }
    }
}
