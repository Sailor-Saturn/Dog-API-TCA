import ComposableArchitecture
import Foundation

public struct Dog: Codable {
    let name: String
    let imageReference: String
    
    enum CodingKeys: String, CodingKey {
            case name
            // After implementing the requirement #2 I noticed that the returned object query returns a image reference id and not a image so I need to add a new field to this struct
            case imageReference = "reference_image_id"
    }
}
