import UIKit
import RxSwift

/// Interface for Article repo.
protocol ArticleRepo {
    
    /// Fetch Article.
    ///
    /// - Parameter params: API parameters
    /// - Returns: RxSwift Observable of Article array.
    func fetchArticles(params: [String: String]?) -> Observable<[Article]>
}
