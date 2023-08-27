import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: StoreOf<RootReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            DogListView(
                store: self.store.scope(state: \.dogListState, action: RootReducer.Action.dogList)
            )
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: Store(
                initialState: RootReducer.State()
            ) {
                RootReducer(
//                    fetchDogList: { _,_ in .mock },
//                    fetchImage: { _ in URL(string: "https://cdn2.thedogapi.com/images/hMyT4CDXR.jpg")!}
                )
            }
        )
    }
}
