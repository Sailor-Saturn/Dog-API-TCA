import SwiftUI
import ComposableArchitecture
import Kingfisher

struct DetailedDogView: View {
    @State var fetchingImage: Bool = false
    
    let store: Store<DetailedDogReducer.State, DetailedDogReducer.Action>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                if viewStore.dataLoadingStatus == .success {
                    KFImage(viewStore.url)
                        .placeholder { _ in
                            if fetchingImage {
                                ProgressView()
                            }
                        }
                        .fade(duration: .fadeDuration)
                        .onProgress{ received, total in
                            fetchingImage = received == total
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300,height: 300)
                    .padding(.top, .bodyTopPadding)}
            }
            .onAppear{
                viewStore.send(.view(.onAppear))
            }
            
        }
        
    }
    
}

// MARK: - Constants
private extension CGFloat {
    static let stackSpacing: Self = 16
    static let defaultPadding: Self = 16
    static let bodyTopPadding: Self = 32
    static let itemsTitlePadding: Self = 8
    static let bulletSpacingBetweenItems: Self = 12
    static let buttonBottomPadding: Self = 32
    static let bulletPadding: Self = 8
    static let bulletDescriptionSpacing: Self = 12
    static let bulletSize: Self = 6
    static let bulletTopPadding: Self = -8
}

private extension TimeInterval {
    static let fadeDuration: Self = 0.25
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
