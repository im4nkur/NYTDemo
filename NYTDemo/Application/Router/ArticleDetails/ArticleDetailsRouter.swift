import UIKit

protocol ArticleDetailsRouterProtocol {
    func showArticleDetails(for model: ArticleModel)
}

/// Router class for Article details.
class ArticleDetailsRouter: ArticleDetailsRouterProtocol {
    private var presentingViewController: UIViewController?
    
    /// Initializer
    ///
    /// - Parameter viewController: presenting view controller.
    init(viewController: UIViewController) {
        presentingViewController = viewController
    }
    
    /// Function to show Article details view.
    ///
    /// - Parameter model: ArticleModel
    internal func showArticleDetails(for model: ArticleModel) {
        guard let navigationController = presentingViewController?.navigationController else {
            assertionFailure("Navigation Controller not found.")
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let imageDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as? ArticleDetailsViewController {
            imageDetailsViewController.article = model
            navigationController.pushViewController(imageDetailsViewController, animated: true)
        }
    }
}
