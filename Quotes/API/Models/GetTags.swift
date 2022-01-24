//
//  GetTags.swift
//  Quotes
//
//  
//

import Foundation

struct GetTags : Codable {
    let _id : String?
    let name : String?
    let dateAdded : String?
    let dateModified : String?
    let __v : Int?
    let quoteCount : Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case name = "name"
        case dateAdded = "dateAdded"
        case dateModified = "dateModified"
        case __v = "__v"
        case quoteCount = "quoteCount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        dateAdded = try values.decodeIfPresent(String.self, forKey: .dateAdded)
        dateModified = try values.decodeIfPresent(String.self, forKey: .dateModified)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
        quoteCount = try values.decodeIfPresent(Int.self, forKey: .quoteCount)
    }

}
