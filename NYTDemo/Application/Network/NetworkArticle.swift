import UIKit

/// Network Data Model for NYT Article API
struct NYTData: Codable {
    var status: String
    var copyright: String
    var results: [NetworkArticle]
}
struct NetworkArticle: Codable {
    var url: String
    var section: String
    var byline: String
    var type: String
    var title: String
    var abstract: String
    var publishedDate: String
    var source: String
    var id: Int
    var views: Int
    var media: [NetworkMedia]
}

struct NetworkMedia: Codable {
    var type: String
    var subtype: String
    var caption: String
    var copyright: String
    var mediaData: [NetworkMediaData]
    private enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case mediaData = "media-metadata"
    }
}

struct NetworkMediaData: Codable {
    var url: String
    var format: String
    var height: Int
    var width: Int
}
