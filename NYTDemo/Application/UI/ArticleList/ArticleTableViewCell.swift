import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    internal func setData(article: ArticleModel) {
        title.text = article.title
        author.text = article.byline
        date.text = article.publishedDate
        articleImage.layer.cornerRadius = articleImage.bounds.height / 2
        articleImage.clipsToBounds = true
        articleImage.contentMode = .scaleAspectFit
        let urlString = article.media?.thumbnail ?? ""
        setImage(url: URL(string: urlString), view: articleImage)
    }

    
    /// Get Image from URL and set to image view.
    ///
    /// - Parameters:
    ///   - url: url
    ///   - view: image view on which image needs to be set.
    private func setImage(url: URL?, view: UIImageView?) {
        view?.image = nil
        guard let imageUrl = url else {
            view?.image = UIImage(named: "PlaceHolderImage")
            return
        }
        FetchImageFromURL(url: imageUrl.absoluteString).downloadImage(onSuccess: { (image) in
            DispatchQueue.main.async {
                view?.image = image
            }
        }) { (error) in
            DispatchQueue.main.async {
                view?.image = UIImage(named: "PlaceHolderImage")
            }
        }
    }
}
