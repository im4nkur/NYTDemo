import UIKit
import RxSwift

/// Implementer class for  Article List.
class ArticleListImpl: ArticleListPresenter {
    var articleRepo: ArticleRepo
    
    init(repo: ArticleRepo) {
        self.articleRepo = repo
    }
    
    /// Fetch Articles.
    ///
    /// - Parameter params: API parameters
    /// - Returns: RxSwift Observable of ArticleModel array.
    func fetchArticles(params: [String: String]?) -> Observable<[ArticleModel]> {
        let intractor = FetchArticlesImpl(repo: articleRepo)
        let articles = intractor.fetchArticles(params: params).map { (articles) -> [ArticleModel] in
            return articles.map({ModelsConverter().convertArticleDomainToPresentationModel(article: $0)})
        }
        return articles
    }
}
