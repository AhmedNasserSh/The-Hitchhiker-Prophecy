//
//  CharacterDetailsSceneViewControllerTests.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import XCTest
@testable import The_Hitchhiker_Prophecy

class CharacterDetailsSceneViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testCallInteractorFetch() throws {
        // setup Dependencies
        let interactorMock = CharachterDetailsSceneInteractorMock()
        let characterDetailsSceneViewController = CharacterDetailsSceneViewController()
        characterDetailsSceneViewController.interactor = interactorMock
        
        //fetch  charcters
        characterDetailsSceneViewController.viewDidLoad()
        
        XCTAssertTrue(interactorMock.didCallFetchCharacter, "ViewController dosen't call the interactor")
    }


}
