import Foundation
import ComposableArchitecture

struct DogListReducer: Reducer {
    struct State: Equatable {
        var dataLoadingStatus = DataLoadingStatus.notStarted
        
        var dogList: IdentifiedArrayOf<DetailedDogReducer.State> = []
        
        
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
        
        var currentPage: Int = 0
        var pageLimit: Int = 10
    }
    
    enum Action: Equatable {
        case fetchDogList
        case fetchDogListResponse(TaskResult<[Dog]>)
        case dog(id: DetailedDogReducer.State.id, dog: DetailedDogReducer.State.dog)
    }
    
    enum Cancellables {
        case fetchingScheduleSlots
        case fetchingLanguages
    }
    
    @Dependency(\.petService) private var petService
    @Dependency(\.uuid) private var uuid
    @Dependency(\.loggerService) private var loggerService
    
    public var body: some Reducer<State, Action> {
        Reduce<State, Action> { state, action in
            switch action {
            case .fetchDogList:
                state.dataLoadingStatus = .loading
                return .run { [pageLimit = state.pageLimit, currentPage = state.currentPage] send in
                    await send(.fetchDogListResponse(
                        TaskResult{
                            try await petService.fetchList(pageLimit, currentPage)
                        }
                    ))
                }
            case .fetchDogListResponse(.success(let dogs)):
                state.dataLoadingStatus = .success
                state.dogList = IdentifiedArrayOf(
                    uniqueElements: dogs.map {
                        DetailedDogReducer.State(id: uuid(), dog: $0)
                    })
                
            case .fetchDogListResponse(.failure(let error)):
                state.dataLoadingStatus = .error
                loggerService.log(error.localizedDescription, .error)
                return .none
            }
        }.forEach(\.dogList, action: /DogListReducer.Action.dog(id: dog:)) {
            DetailedDogReducer()
        }
    }
}
