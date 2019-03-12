import UIKit
import RxSwift

/// Interface for Article List.
protocol ArticleListPresenter {
    
    /// Fetch Articles.
    ///
    /// - Parameter params: API parameters
    /// - Returns: RxSwift Observable of ArticleModel array.
    func fetchArticles(params: [String: String]?) -> Observable<[ArticleModel]>
}
