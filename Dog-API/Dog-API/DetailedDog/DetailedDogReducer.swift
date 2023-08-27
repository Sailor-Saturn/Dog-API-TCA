import Foundation
import ComposableArchitecture

public struct DetailedDogReducer: Reducer {
    public struct State: Equatable {
        public let id: UUID
        public let dog: Dog
        
    }
    
    public enum Action: Equatable {
    }
   
    public var body: some Reducer<State, Action> {
        Reduce<State, Action> { state, action in
            switch action {
                
            }
        }
    }
}
