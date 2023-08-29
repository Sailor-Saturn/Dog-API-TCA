import Foundation
import ComposableArchitecture

struct DetailedDogReducer: Reducer {
    struct State: Equatable, Identifiable {
        var dataLoadingStatus = DataLoadingStatus.notStarted
        public let id: UUID
        public let dog: Dog
        public var url: URL?
        
    }
    
    enum Action: Equatable {
        enum ViewAction: Equatable {
            case onAppear
        }
        case fetchImageResponse(TaskResult<URL>)
        
        case view(ViewAction)
    }
    
    enum Cancellables {
        case fetchingImage
    }
    
    @Dependency(\.petService) private var petService
    public var body: some Reducer<State, Action> {
        Reduce<State, Action> { state, action in
            switch action {
            case .view(.onAppear):
                        state.dataLoadingStatus = .loading
                return .run { [image = state.dog.imageReference] send in
                            await send(.fetchImageResponse(
                                TaskResult{
                                    try await petService.fetchImage(image)
                                }
                            ))
                        }.cancellable(id: Cancellables.fetchingImage)
            case .fetchImageResponse(.success(let url)):
                state.dataLoadingStatus = .success
                state.url = url
                return .none
                
            case .fetchImageResponse(.failure), .view:
                return .none
            }
        }
    }
}
