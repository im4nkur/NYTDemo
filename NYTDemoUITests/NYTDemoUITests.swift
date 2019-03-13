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

    func testUIElements() {
        
        let app = XCUIApplication()
        let article = app.tables/*@START_MENU_TOKEN@*/.cells.staticTexts["H.I.V. Is Reported Cured in a Second Patient, a Milestone in the Global AIDS Epidemic"]/*[[".cells.staticTexts[\"H.I.V. Is Reported Cured in a Second Patient, a Milestone in the Global AIDS Epidemic\"]",".staticTexts[\"H.I.V. Is Reported Cured in a Second Patient, a Milestone in the Global AIDS Epidemic\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 10)
        let url = app.textViews.containing(.link, identifier:"https://www.nytimes.com/2019/03/04/health/aids-cure-london-patient.html").element.waitForExistence(timeout: 10)
        let button = app.navigationBars["New York Times"].buttons["New York Times"].waitForExistence(timeout: 10)
        
        
        XCTAssertNotNil(article)
        XCTAssertNotNil(url)
        XCTAssertNotNil(button)
        
    }

}
