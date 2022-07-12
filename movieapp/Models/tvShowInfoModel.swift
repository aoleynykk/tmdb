//
//  tvShowInfoModel.swift
//  movieapp
//
//  Created by Олександр Олійник on 11.07.2022.
//

import Foundation

struct tvShowInfoModel : Codable {
    let backdrop_path : String?
    let id : Int?
    let name : String?
    let number_of_episodes : Int?
    let number_of_seasons : Int?
    let overview : String?
    let poster_path : String?
    let tagline : String?
    let vote_average : Double?
    let vote_count : Int?

    enum CodingKeys: String, CodingKey {

        case backdrop_path = "backdrop_path"
        case id = "id"
        case name = "name"
        case number_of_episodes = "number_of_episodes"
        case number_of_seasons = "number_of_seasons"
        case overview = "overview"
        case poster_path = "poster_path"
        case tagline = "tagline"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        number_of_episodes = try values.decodeIfPresent(Int.self, forKey: .number_of_episodes)
        number_of_seasons = try values.decodeIfPresent(Int.self, forKey: .number_of_seasons)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
        vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
        vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
    }
}
