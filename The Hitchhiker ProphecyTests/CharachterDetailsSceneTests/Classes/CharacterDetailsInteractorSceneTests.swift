//
//  CharacterDetailsInteractorSceneTests.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import XCTest
@testable import The_Hitchhiker_Prophecy

class CharacterDetailsInteractorSceneTests: XCTestCase {
        
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testFetchCharacter() throws {
        // setup Dependencies
        let presenterMock = CharachterDetailsScenePresenterMock()
        let charcterData = ResponseMockHelper<Characters.Search.Character>()
            .getMockResponse(jsonFileName: "CharactersData")
            .getSuccessData()!
        
        let charachterDetailsInteractor = CharacterDetailsSceneInteractor(character: charcterData, presenter: presenterMock)
        
        // fetch charcter
        charachterDetailsInteractor.fetchCharacter()
        
        // update Presenter
        XCTAssertTrue(presenterMock.didDisplayCharcter,"Interactor dosen't update the presenter")
        
    }

}
