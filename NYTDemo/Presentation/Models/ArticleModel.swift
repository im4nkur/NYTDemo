import UIKit

/// Presentation model for Article.
struct ArticleModel {
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
    var media: MediaModel?
}

struct MediaModel {
    var type: String
    var caption: String
    var copyright: String
    var thumbnail: String
    var largeImage: String
}
