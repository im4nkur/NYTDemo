import UIKit
import RxSwift

protocol FetchArticleIntractor {
    /// Fetch Articles.
    ///
    /// - Parameter params: API parameters
    /// - Returns: RxSwift Observable of Article array.
    func fetchArticles(params: [String: String]?) -> Observable<[Article]>
}
