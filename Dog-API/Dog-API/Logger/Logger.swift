import Logging

public struct LoggerService {
    var log: (String, LogType) async throws -> Void
}

public enum LogType {
    case info
    case error
    case warning
}

extension LoggerService {
    public static func live() -> Self {
        let logger = Logger(label: "Sailor-Saturn.Dog-API")
        return .init(
            log: { message, logType in
                let logMessage: Logger.Message = .init(stringLiteral: message)
                switch logType {
                case .info:
                    logger.info(logMessage)
                case .error:
                    logger.error(logMessage)
                case .warning:
                    logger.warning(logMessage)
                }
            }
        )
    }
}
