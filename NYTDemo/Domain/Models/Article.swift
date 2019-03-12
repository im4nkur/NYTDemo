import UIKit

/// Domain model for Article.
struct Article {
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
    var media: [Media]
}

struct Media {
    var type: String
    var subtype: String
    var caption: String
    var copyright: String
    var mediaData: [MediaData]
}

struct MediaData {
    var url: String
    var format: String
    var height: Int
    var width: Int
}
