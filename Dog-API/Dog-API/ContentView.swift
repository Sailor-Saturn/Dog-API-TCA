

import SwiftUI

struct Photo: Identifiable {
    var id = UUID()
    var name: String
}

let samplePhotos = (1...20).map { Photo(name: "coffee-\($0)") }

struct ContentView: View {
    @State var gridLayout: [GridItem] = [ GridItem() ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                
                ForEach(samplePhotos.indices, id: \.self) { index in
                    
                    Image(samplePhotos[index].name)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .shadow(color: Color.primary.opacity(0.3), radius: 1)
                    
                }
            }
            .padding(.all, 10)
        }
        .navigationTitle("Coffee Feed")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
