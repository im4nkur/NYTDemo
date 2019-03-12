import UIKit
import RxSwift

class FetchArticlesImpl: FetchArticleIntractor {
    var articleRepo: ArticleRepo
    
    init(repo: ArticleRepo) {
        self.articleRepo = repo
    }
    /// Fetch Articles.
    ///
    /// - Parameter params: API parameters
    /// - Returns: RxSwift Observable of Article array.
    func fetchArticles(params: [String: String]?) -> Observable<[Article]> {
        // Do aditional computation
        return articleRepo.fetchArticles(params: params)
    }

}
