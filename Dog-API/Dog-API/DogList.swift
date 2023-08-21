import ComposableArchitecture
import Alamofire
import SwiftUI

struct DogListFeature: Reducer {
    struct State {
        var dogs: [Dog] = [] // TODO: Add mock dogs 
    }
    
    enum Action {
        case onAppear
    }
}

struct DogListView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DogListView_Previews: PreviewProvider {
    static var previews: some View {
        DogListView()
    }
}

// TODO: Change this to service dependency
func fetchDogs(query: String, callback: @escaping ([Dog]?) -> Void) -> Void {
//    let url = URL(string: Bundle.main.object(forInfoDictionaryKey: "DOG_API_URL") as! String)!
//    var request = URLRequest(url: url)
//    request.setValue(ProcessInfo.processInfo.environment["API_KEY"]!, forHTTPHeaderField:"Content-Type")
//    request.httpMethod = "POST"
    let headers : HTTPHeaders = [
        "Content-Type":"application/json",
        "x-api-key": ProcessInfo.processInfo.environment["API_KEY"]!]
    
    let headers1: HTTPHeaders = [
        .authorization(bearerToken: ProcessInfo.processInfo.environment["API_KEY"]!),
        .accept("application/json")
    ]
    AF.request("https://api.thedogapi.com/v1/", headers: headers1) { response in
//        response.
    }
    
    
//    .responseDecodable(of: [Dog].self) { response in
//        guard let dogs = response.data else {
//            return
//        }
//
//        callback(
//            dogs.map(Dog.init)
//        )
//    }
    
//    URLSession.shared.dataTask(with: request) { data, response, error in
//        callback(
//            data
//                .flatMap { elements
//                    for elem in elements
//
//                }
//        )
//    }
//    .resume()
}
