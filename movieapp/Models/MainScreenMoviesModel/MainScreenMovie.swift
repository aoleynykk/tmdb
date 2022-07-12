

import Foundation

struct MainScreenMovie : Codable {
    
    let id : Int?
    let poster_path : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case poster_path = "poster_path"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
    }
}
