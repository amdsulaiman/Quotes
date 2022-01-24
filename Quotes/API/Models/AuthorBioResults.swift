//
//  AuthorBioResults.swift
//  Quotes
//
// 
//

import Foundation

struct AuthorBioResults : Codable {
    let link : String?
    let bio : String?
    let description : String?
    let _id : String?
    let name : String?
    let quoteCount : Int?
    let slug : String?
    let dateAdded : String?
    let dateModified : String?

    enum CodingKeys: String, CodingKey {

        case link = "link"
        case bio = "bio"
        case description = "description"
        case _id = "_id"
        case name = "name"
        case quoteCount = "quoteCount"
        case slug = "slug"
        case dateAdded = "dateAdded"
        case dateModified = "dateModified"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        quoteCount = try values.decodeIfPresent(Int.self, forKey: .quoteCount)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        dateAdded = try values.decodeIfPresent(String.self, forKey: .dateAdded)
        dateModified = try values.decodeIfPresent(String.self, forKey: .dateModified)
    }

}
