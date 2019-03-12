import UIKit
import RxSwift

class ArticleListViewController: BaseViewController {
    
    @IBOutlet weak var articleTableView: UITableView?

    var loader: Loader?
    let cellIdentifier = "ArticleTableViewCell"
    var articles: [ArticleModel]?
    var lastContentOffset: CGFloat = 0.0
    var isScrollingUp: Bool = false
    var articlesListPresenter: ArticleListPresenter?
    let disposeBag = CompositeDisposable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleTableView?.tableFooterView = UIView()
        loader = Loader(view: self.view, style: .whiteLarge)
        fetchArticles()
    }
    
    /// Fetch Articles from Repo.
    private func fetchArticles() {
        loader?.start()
        let articleRepo: ArticleRepo = NetworkArticlesRepo()
        articlesListPresenter = ArticleListImpl(repo: articleRepo)
        let myBusyScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        if let disposable = articlesListPresenter?.fetchArticles(params:nil)
            .subscribeOn(myBusyScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (articles) in
                self.articles = articles
                self.loader?.stop()
                self.articleTableView?.reloadData()
            }, onError: { (error) in
                self.showError(with: error)
                self.loader?.stop()
            }) {
            let _ = disposeBag.insert(disposable)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        disposeBag.dispose()
    }
}

extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ArticleTableViewCell {
            if let article = articles?[indexPath.row] {
                cell.setData(article: article)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let article = articles?[indexPath.row] {
            let router = ArticleDetailsRouter(viewController: self)
            let presenter = ArticleDetailsRouterPresenter(router: router)
            presenter.showArticleDetails(for: article)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let direction: CGFloat = isScrollingUp ? -200 : 200
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, direction, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.45) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isScrollingUp = self.lastContentOffset > scrollView.contentOffset.y
        self.lastContentOffset = scrollView.contentOffset.y;
    }

}
