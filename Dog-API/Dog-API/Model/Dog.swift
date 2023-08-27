import ComposableArchitecture
import Foundation

public struct Dog: Equatable, Codable {
    let name: String
    let imageReference: String
    let temperament: String
    let breedGroup: String?
    let origin: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        // After implementing the requirement #2 I noticed that the returned object query returns a image reference id and not a image so I need to add a new field to this struct
        case imageReference = "reference_image_id"
        case temperament
        case breedGroup = "breed_group"
        case origin = "origin"
    }
}

public extension Array where Element == Dog {
    static var mock: Self {
        [
            .init(
                name: "Affenpinscher",
                imageReference: "BJa4kxc4X",
                temperament: "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving",
                breedGroup: "Toy",
                origin: "Germany, France"
            ),
            .init(
                name: "African Hunting Dog",
                imageReference: "rkiByec47",
                temperament: "Wild, Hardworking, Dutiful",
                breedGroup: "Toy",
                origin: ""
            ),
            .init(
                name: "Airedale Terrier",
                imageReference: "1-7cgoZSh",
                temperament: "Outgoing, Friendly, Alert, Confident, Intelligent, Courageous",
                breedGroup: "Terrier",
                origin: "United Kingdom, England"
            ),
            .init(
                name: "Akita",
                imageReference: "BFRYBufpm",
                temperament: "Docile, Alert, Responsive, Dignified, Composed, Friendly, Receptive, Faithful, Courageous",
                breedGroup: "Working",
                origin: nil
            )
        ]
    }
}
