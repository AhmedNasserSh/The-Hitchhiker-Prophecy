//
//  CharacterDetailsSceneViewControllerUITests.swift
//  The Hitchhiker ProphecyUITests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import XCTest

class CharacterDetailsSceneViewControllerUITests: XCTestCase {

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
    }
    
    //MARK: test CharacterDetailsScene is shown with correct data
    func testCharacterDetailsSceneIsShown() throws {
        let firstCell =  XCUIApplication().collectionViews.cells.children(matching: .any).element(boundBy: 0)
        let firstCellNameLabelText = firstCell
            .children(matching: .staticText)
            .element(matching: .staticText
                     , identifier: AccessiblityIdsReference
                        .HomeSceneIds
                        .characterNameLabelAccessiblityIdentifier
                        .rawValue)
            .label
        
        //navigate to details view
        firstCell.tap()
        
        //check if the data is shown
        let charcterDetailsNameLabelText = XCUIApplication()
            .staticTexts[AccessiblityIdsReference .CharcterDetailsSceneIds
                            .characterDetailsNameLabelAccessiblityIdentifier
                            .rawValue]
            .label
        
        XCTAssertEqual(firstCellNameLabelText, charcterDetailsNameLabelText, "Details screen dosen't show data correctly")
    }

}
