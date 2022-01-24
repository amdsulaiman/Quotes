//
//  Tags.swift
//  Quotes
//
// 
//

import Foundation
struct Tags : Codable {
    let count : Int?
    let totalCount : Int?
    let page : Int?
    let totalPages : Int?
    let lastItemIndex : Int?
    let results : [TagsDetails]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case totalCount = "totalCount"
        case page = "page"
        case totalPages = "totalPages"
        case lastItemIndex = "lastItemIndex"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        lastItemIndex = try values.decodeIfPresent(Int.self, forKey: .lastItemIndex)
        results = try values.decodeIfPresent([TagsDetails].self, forKey: .results)
    }

}
