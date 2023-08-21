import Dependencies

extension LoggerService: DependencyKey {
    public static let liveValue: LoggerService = .live()
}

extension DependencyValues {
    public var loggerService: LoggerService {
        get { self[LoggerService.self] }
        set { self[LoggerService.self] = newValue }
    }
}
