import UIKit

/// Article Details Class
class ArticleDetailsViewController: BaseViewController {
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var abstract: UILabel!
   
    
    var loader: Loader?
    var article: ArticleModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        loader = Loader(view: articleImage, style: .whiteLarge)
        let urlString = article?.media?.largeImage ?? ""
        setImage(url: URL(string: urlString), view: articleImage)
        articleTitle.text = article?.title
        abstract.text = article?.abstract
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    /// Get Image from URL and set to image view.
    ///
    /// - Parameters:
    ///   - url: url
    ///   - view: image view on which image needs to be set.
    private func setImage(url: URL?, view: UIImageView?) {
        loader?.start()
        view?.image = nil
        guard let imageUrl = url else {
            view?.image = UIImage(named: "PlaceHolderImage")
            loader?.stop()
            return
        }
        FetchImageFromURL(url: imageUrl.absoluteString).downloadImage(onSuccess: { (image) in
            DispatchQueue.main.async {
                view?.image = image
                self.loader?.stop()
            }
        }) { (error) in
            DispatchQueue.main.async {
                view?.image = UIImage(named: "PlaceHolderImage")
                self.loader?.stop()
            }
        }
    }

}
