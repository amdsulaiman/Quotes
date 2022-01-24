

import Foundation
struct Results : Codable {
	let tags : [String]?
	let _id : String?
	let author : String?
	let content : String?
	let authorSlug : String?
	let length : Int?
	let dateAdded : String?
	let dateModified : String?

	enum CodingKeys: String, CodingKey {

		case tags = "tags"
		case _id = "_id"
		case author = "author"
		case content = "content"
		case authorSlug = "authorSlug"
		case length = "length"
		case dateAdded = "dateAdded"
		case dateModified = "dateModified"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		tags = try values.decodeIfPresent([String].self, forKey: .tags)
		_id = try values.decodeIfPresent(String.self, forKey: ._id)
		author = try values.decodeIfPresent(String.self, forKey: .author)
		content = try values.decodeIfPresent(String.self, forKey: .content)
		authorSlug = try values.decodeIfPresent(String.self, forKey: .authorSlug)
		length = try values.decodeIfPresent(Int.self, forKey: .length)
		dateAdded = try values.decodeIfPresent(String.self, forKey: .dateAdded)
		dateModified = try values.decodeIfPresent(String.self, forKey: .dateModified)
	}

}
