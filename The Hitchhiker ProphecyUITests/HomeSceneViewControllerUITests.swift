//
//  HomeSceneViewControllerUITests.swift
//  The Hitchhiker ProphecyUITests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import XCTest

let characterNameLabelAccessiblityIdentifier =  "characterNameLabelAccessiblityIdentifier"
let characterImageViewAccessiblityIdentifier =  "characterImageViewAccessiblityIdentifier"
let changeLayoutButtonAccessiblityIdentifier =  "changeLayoutButtonAccessiblityIdentifier"

class HomeSceneViewControllerUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
    }
    
    override func tearDownWithError() throws {
    }
    
    //MARK: test if loading view is shown at first
    func testShowingActivityIndicator() throws {
        let indicator = XCUIApplication().activityIndicators.element
        XCTAssertTrue(indicator.exists, "Indicator dosen't show on data fetching")

    }
    
    //MARK: test if loading view is hiidden after the data is fetched
    func testHidingActivityIndicator() throws{
        let indicator = XCUIApplication().activityIndicators.element
        XCTAssertFalse(indicator.waitForExistence(timeout: 6), "Indicator dosen't hide after data fetching")
    }
    
    //MARK: test if celss are Loading after the data is fetched
    func testLoadingCellsCorrectly() throws {
        let firstCell =  XCUIApplication().collectionViews.cells.children(matching: .any).element(boundBy: 0)
        let charcterImage = firstCell.children(matching: .image).element(matching: .image, identifier: characterImageViewAccessiblityIdentifier)
        let charcterNameLabel = firstCell.children(matching: .staticText).element(matching: .staticText, identifier: characterNameLabelAccessiblityIdentifier)
        
        XCTAssertTrue(charcterImage.waitForExistence(timeout: 5), "cell image dosen't load")
        XCTAssertTrue(charcterNameLabel.waitForExistence(timeout: 5), "cell label dosen't load")
        
    }
    
    //MARK: test change Layout works correctly
    func testChangingLayout() throws {

        // tap first to change the layout to vertical list
        let changeLayoutButton = XCUIApplication().buttons[changeLayoutButtonAccessiblityIdentifier]
        changeLayoutButton.tap()
        
        // check the cell height is matching the vertical height assigned
        var itemCell =  XCUIApplication().collectionViews.cells.children(matching: .any).element(boundBy: 0)
        
        XCTAssertEqual(itemCell.frame.height, 250, "View Doesn't adjust vertical layout correctly")

        //tab again to return to the gird view
        changeLayoutButton.tap()
        
        // check the cell height is matching the hoorizontal height assigned
        itemCell =  XCUIApplication().collectionViews.cells.children(matching: .any).element(boundBy: 0)
        let collectionViewFrame = XCUIApplication().collectionViews.element.frame

        XCTAssertEqual(itemCell.frame.height, collectionViewFrame.height - 40, "View Doesn't adjust vertical layout correctly")
    }
    
}
