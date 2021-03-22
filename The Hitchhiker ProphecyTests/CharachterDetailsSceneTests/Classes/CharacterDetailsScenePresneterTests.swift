//
//  CharacterDetailsScenePresneterTests.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import XCTest
@testable import The_Hitchhiker_Prophecy

class CharacterDetailsScenePresneterTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testMappingCharacters() throws {
        // setup Dependencies
        let viewControllerMock = CharachterDetailsSceneDisplayViewMock()
        let charcterData = ResponseMockHelper<Characters.Search.Character>()
            .getMockResponse(jsonFileName: "CharactersData")
            .getSuccessData()!
        let characterDetailsScenePresneter = CharacterDetailsScenePresenter(displayView: viewControllerMock)

        // present respons charcter
        characterDetailsScenePresneter.presentCharacter(charcterData)
        
        //update View With View Model
        XCTAssertEqual(viewControllerMock.viewModel?.name, "Hulk", "presenter dosen't map data Correctly")
        
    }

}
