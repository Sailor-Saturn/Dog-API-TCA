import SwiftUI
import ComposableArchitecture

struct DogListView: View {
    let store: StoreOf<DogListReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
        }
    }
}

struct DogListView_Previews: PreviewProvider {
    static var previews: some View {
        DogListView(
            store: Store(
                initialState: DogListReducer.State()
            ) {
                DogListReducer(
//                    fetchDogList: { _,_ in .mock },
//                    fetchImage: { _ in URL(string: "https://cdn2.thedogapi.com/images/hMyT4CDXR.jpg")!}
                )
            }
        )
    }
}
