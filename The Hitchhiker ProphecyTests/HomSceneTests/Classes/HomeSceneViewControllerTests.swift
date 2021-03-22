//
//  HomeSceneViewControllerTests.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import XCTest
@testable import The_Hitchhiker_Prophecy

class HomeSceneViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testCallInteractorFetch() throws {
        // setup Dependencies
        let interactorMock = HomeSceneInteractorMock()
        let homeSceneViewController = HomeSceneViewController()
        homeSceneViewController.interactor = interactorMock
        
        //fetch  charcters
        homeSceneViewController.viewDidLoad()
        
        XCTAssertTrue(interactorMock.didCallFetchCharacters, "ViewController dosen't call the interactor")
    }


}
