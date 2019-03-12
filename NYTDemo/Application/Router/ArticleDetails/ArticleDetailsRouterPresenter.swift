import UIKit

protocol ArticleDetailsRouterPresenterProtocol {
    func showArticleDetails(for model: ArticleModel)
}

/// Presenter class for Article details router.
class ArticleDetailsRouterPresenter: ArticleDetailsRouterPresenterProtocol {
    
    /// Function to show Article details view.
    ///
    /// - Parameter model: ArticleModel
    internal func showArticleDetails(for model: ArticleModel) {
        self.router?.showArticleDetails(for: model)
    }
    
    var router: ArticleDetailsRouterProtocol?
    
    /// Initializer
    ///
    /// - Parameter router: Article details router protocol.
    init(router: ArticleDetailsRouterProtocol) {
        self.router = router
    }
}
