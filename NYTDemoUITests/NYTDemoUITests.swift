import XCTest

class NYTDemoUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Test cases are recorded using DummyArticleRepo() in ArticleListViewController
        let app = XCUIApplication()
        app.otherElements.containing(.navigationBar, identifier:"New York Times").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.swipeDown()
       let article1 = app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Test Article 1")/*[[".cells.containing(.staticText, identifier:\"20 Feb 2019\")",".cells.containing(.staticText, identifier:\"Test Article 1\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["By Ankur Arya"].exists
        
        XCTAssertEqual(article1, true)
        
        let articleNA = app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Test Article 1")/*[[".cells.containing(.staticText, identifier:\"20 Feb 2019\")",".cells.containing(.staticText, identifier:\"Test Article 1\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["By Unknown"].exists
        
        XCTAssertEqual(articleNA, false)
    }

}
