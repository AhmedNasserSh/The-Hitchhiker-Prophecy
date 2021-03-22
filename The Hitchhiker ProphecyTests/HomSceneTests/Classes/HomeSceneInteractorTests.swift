//
//  HomeSceneInteractorTests.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import XCTest
@testable import The_Hitchhiker_Prophecy

class HomeSceneInteractorTests: XCTestCase {
        
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testFetchCharactersResults() throws {
        // setup Dependencies
        let presnterMock = HomeScenePresneterMock()
        let workerMock = HomeSceneWorkerTypeMock()
        let homeSceneInteractor = HomeSceneInteractor(worker: workerMock, presenter: presnterMock)
        
        // fetch charcters
        homeSceneInteractor.fetchCharacters()
        
        // update Presenter
        XCTAssertEqual(homeSceneInteractor.result?.results.count, 1, "Interactor dosen't update the presenter")
        
    }

    func testFetchCharactersUpdate() throws {
        // setup Dependencies
        let presnterMock = HomeScenePresneterMock()
        let workerMock = HomeSceneWorkerTypeMock()
        let homeSceneInteractor = HomeSceneInteractor(worker: workerMock, presenter: presnterMock)
        
        // fetch charcters
        homeSceneInteractor.fetchCharacters()
        
        // update Presenter
        XCTAssertTrue(presnterMock.didPresentCharcters, "Interactor dosen't update the presenter")
        
    }

}
