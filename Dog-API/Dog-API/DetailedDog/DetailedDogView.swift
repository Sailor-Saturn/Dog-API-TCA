import SwiftUI
import ComposableArchitecture

struct DetailedDogView: View {
    let store: Store<DetailedDogReducer.State, DetailedDogReducer.Action>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
        }
    }
}

struct DetailedDogView_Previews: PreviewProvider {
    static var previews: some View {
        @Dependency(\.uuid) var uuid
        DetailedDogView(
            store: Store(
                initialState: DetailedDogReducer.State(id: uuid(), dog: [Dog].mock.first!)
            ) {
                DetailedDogReducer()
            }
        )
    }
}
