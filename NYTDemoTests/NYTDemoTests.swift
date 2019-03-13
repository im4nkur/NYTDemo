import XCTest
import RxSwift

@testable import NYTDemo

class NYTDemoTests: XCTestCase {
    var articlesListPresenter: ArticleListPresenter?
    let disposeBag = CompositeDisposable()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConvertArticleDomainToPresentationModel() {
        let presentation = ModelsConverter().convertArticleDomainToPresentationModel(article: domainModel)
        
        XCTAssertEqual(domainModel.abstract, presentation.abstract)
    }
    
    func testConvertArticleNetworkToDomainModel() {
        let domain = ModelsConverter().convertArticleNetworkToDomainModel(networkModel: networkModel)
        
        XCTAssertEqual(networkModel.abstract, domain.abstract)
    }
    
    func testFetchArticlesIntractorWithNetworkRepo() {
        let ex = expectation(description: "articles")
        let articleRepo: ArticleRepo = NetworkArticlesRepo()
        articlesListPresenter = ArticleListImpl(repo: articleRepo)
        let myBusyScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        if let disposable = articlesListPresenter?.fetchArticles(params:nil)
            .subscribeOn(myBusyScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (articles) in
                ex.fulfill()
                XCTAssertNotNil(articles)
            }, onError: { (error) in
                ex.fulfill()
                XCTFail("Error: \(error.localizedDescription)")
            }) {
            let _ = disposeBag.insert(disposable)
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testFetchArticlesIntractorWithDummyRepo() {
        let ex = expectation(description: "dummyArticles")
        let articleRepo: ArticleRepo = DummyArticleRepo()
        articlesListPresenter = ArticleListImpl(repo: articleRepo)
        let myBusyScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        if let disposable = articlesListPresenter?.fetchArticles(params:nil)
            .subscribeOn(myBusyScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (articles) in
                ex.fulfill()
                XCTAssertNotNil(articles)
            }, onError: { (error) in
                ex.fulfill()
                XCTFail("Error: \(error.localizedDescription)")
            }) {
            let _ = disposeBag.insert(disposable)
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }

    var domainModel: Article {
        let mediaData1 = MediaData(url: "http://abc.com", format: "Standard Thumbnail", height: 200, width: 200)
        let mediaData2 = MediaData(url: "http://abcd.com", format: "Large", height: 400, width: 400)
        
        let media = Media(type: "Photo", subtype: "Image", caption: "This is a photo", copyright: "Ankur - All Rights Reserved", mediaData: [mediaData1, mediaData2])
        
        return Article(url: "http://abc.com", section: "Health", byline: "By Ankur Arya", type: "Article", title: "Test Article 1", abstract: "This is a test article 1", publishedDate: "20 Feb 2019", source: "Internet", id: 123, views: 1, media: [media])
        
    }
    var networkModel: NetworkArticle {
        let mediaData1 = NetworkMediaData(url: "http://abc.com", format: "Standard Thumbnail", height: 200, width: 200)
        let mediaData2 = NetworkMediaData(url: "http://abcd.com", format: "Large", height: 400, width: 400)
        
        let media = NetworkMedia(type: "Photo", subtype: "Image", caption: "This is a photo", copyright: "Ankur - All Rights Reserved", mediaData: [mediaData1, mediaData2])
        
        return NetworkArticle(url: "http://abc.com", section: "Health", byline: "By Ankur Arya", type: "Article", title: "Test Article", abstract: "This is a test article", publishedDate: "22 Feb 2019", source: "Internet", id: 127, views: 5, media: [media])
    }
  
}
