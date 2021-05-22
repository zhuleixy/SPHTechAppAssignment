//
//  SPHTechAppAssignmentUITests.swift
//  SPHTechAppAssignmentUITests
//
//  Created by zhulei on 2021/5/19.
//

import XCTest

class SPHTechAppAssignmentUITests: XCTestCase {

    override func setUpWithError() throws {
      
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launch()
        
        //Wait for the network request to complete
        let label = app.staticTexts["Year: 2008"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }

    override func tearDownWithError() throws {
    }

    //Test whether the ImageView can be clicked
    func testClickImageView() throws {
        let app = XCUIApplication()
        app.tables.cells.containing(.staticText, identifier:"Year: 2011").children(matching: .image).element.tap()
        XCTAssertTrue(app.alerts["2011"].exists)
        app.alerts["2011"].scrollViews.otherElements.buttons["ok"].tap()
        XCTAssertFalse(app.alerts["2011"].exists)
    }
    
    //Test whether the TableView can be Swipe
    func testTableViewSwipe() throws {
        let year2011Cell = XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Year: 2011").element/*[[".cells.containing(.staticText, identifier:\"Volume: 14.638703\").element",".cells.containing(.staticText, identifier:\"Year: 2011\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        year2011Cell.swipeUp()
        year2011Cell.swipeDown()
    }
    
}
