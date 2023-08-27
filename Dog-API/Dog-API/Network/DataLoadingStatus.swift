import Foundation

// Enum that will be used on different reducers to know in what step
// are we on regarding the data loading
enum DataLoadingStatus: Equatable {
    case notStarted
    case loading
    case success
    case error
}
