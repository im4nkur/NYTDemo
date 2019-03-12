import UIKit

/// struct for fetching Articles from Repo.
struct FetchArticlesFromServer: HTTPRequestType {
    typealias HTTPResponseType = NYTData
    var params: [String: String]?
    var data: HTTPRequestData {
        return HTTPRequestData(path: DataEndpoint.nytMostPopular.rawValue, params: params)
    }
}

/// struct for fetching image from url.
struct FetchImageFromURL: HTTPDataRequestType {
    var url: String
    var data: HTTPRequestData {
        return HTTPRequestData(path: url)
    }
}

class NetworkManager {
    
    /// Set cache for network calls.
    class func setCaching() {
        let memoryCap = 150 * 1024 * 1024 // 150 MB
        let diskCap = 300 * 1024 * 1024 // 300 MB
        let urlCache = URLCache(memoryCapacity: memoryCap, diskCapacity: diskCap, diskPath: "NYTCache")
        URLCache.shared = urlCache
    }
}
