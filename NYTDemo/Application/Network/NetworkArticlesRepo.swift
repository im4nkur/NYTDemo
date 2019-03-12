import UIKit
import RxSwift

/// Network Article Repo
class NetworkArticlesRepo: ArticleRepo {
    
    /// Fetch Article from Network Repo.
    ///
    /// - Parameter params: API parameters.
    /// - Returns: RxSwift Observable of Article array.
    func fetchArticles(params: [String: String]?) -> Observable<[Article]> {
        return Observable.create({ observer in
            FetchArticlesFromServer(params:params).execute(onSuccess: { ( nytData ) in
                let data = nytData.results.map({ModelsConverter().convertArticleNetworkToDomainModel(networkModel:$0)})
            observer.onNext(data)
            }, onError: { (error) in
                observer.onError(error)
            })
            return Disposables.create {
            }
        })
    }
}
