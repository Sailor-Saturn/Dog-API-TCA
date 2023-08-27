import Foundation
import ComposableArchitecture

struct RootReducer: Reducer {
    public struct State: Equatable {
        var dogListState = DogListReducer.State()
    }
    
    public enum Action: Equatable {
        case dogList(DogListReducer.Action)
    }

    public var body: some Reducer<State, Action> {
        Reduce<State, Action> { state, action in
            switch action {
            case .dogList:
                return .none
            }
        }
        Scope(state: \.dogListState, action: /RootReducer.Action.dogList) {
            DogListReducer()
        }
    }
}
