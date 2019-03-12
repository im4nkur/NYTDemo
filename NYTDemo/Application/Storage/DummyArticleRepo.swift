import UIKit
import RxSwift

class DummyArticleRepo: ArticleRepo {
    
    /// Fetch Articles from Dummy Storage.
    ///
    /// - Parameter params: API parameters.
    /// - Returns: RxSwift Observable of Article array.
    func fetchArticles(params: [String: String]?) -> Observable<[Article]> {
        return Observable.create({ observer in
            let articles = self.getArticles()
            if articles.count > 0 {
                observer.onNext(articles)
                observer.onCompleted()
            } else {
                observer.onError(RxError.noElements)
            }
            return Disposables.create {
            }
        })
    }
    
    private func getArticles() -> [Article] {
        let mediaData1 = MediaData(url: "http://abc.com", format: "Standard Thumbnail", height: 200, width: 200)
        let mediaData2 = MediaData(url: "http://abcd.com", format: "Large", height: 400, width: 400)
        
        let media = Media(type: "Photo", subtype: "Image", caption: "This is a photo", copyright: "Ankur - All Rights Reserved", mediaData: [mediaData1, mediaData2])
        
        let a1 = Article(url: "http://abc.com", section: "Health", byline: "By Ankur Arya", type: "Article", title: "Test Article 1", abstract: "This is a test article 1", publishedDate: "20 Feb 2019", source: "Internet", id: 123, views: 1, media: [media])
        
        let a2 = Article(url: "http://abc.com", section: "Health", byline: "By Ankur Arya", type: "Article", title: "Test Article 2", abstract: "This is a test article 2", publishedDate: "21 Feb 2019", source: "Internet", id: 124, views: 1, media: [media])
        
        let a3 = Article(url: "http://abc.com", section: "Health", byline: "By Ankur Arya", type: "Article", title: "Test Article 3", abstract: "This is a test article 3", publishedDate: "22 Feb 2019", source: "Internet", id: 125, views: 1, media: [media])
       
        return [a1, a2, a3]
    }
}
