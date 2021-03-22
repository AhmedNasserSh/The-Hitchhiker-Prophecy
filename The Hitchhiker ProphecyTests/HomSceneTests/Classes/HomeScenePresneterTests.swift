//
//  HomeScenePresneterTests.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import XCTest
@testable import The_Hitchhiker_Prophecy

class HomeScenePresneterTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testMappingCharacters() throws {
        // setup Dependencies
        let viewControllerMock = HomeSceneDisplayViewMock()
        let homeScenePresneter = HomeScenePresneter(displayView: viewControllerMock)
        
        // present respons charcters
        let data =  ResponseMockHelper<Characters.Search.Output>().getMockResponse(jsonFileName: "CharactersResponseData")
        homeScenePresneter.presentCharacters(data)
        
        
        //update View With View Model
        XCTAssertEqual(viewControllerMock.viewModel.count, 1, "presenter dosen't update View Correctly")
        XCTAssertEqual(viewControllerMock.viewModel[0].name, "Hulk", "presenter dosen't map data Correctly")
        
    }
    
    func testShowViewError() throws {
        // setup Dependencies
        let viewControllerMock = HomeSceneDisplayViewMock()
        let homeScenePresneter = HomeScenePresneter(displayView: viewControllerMock)
        
        //present Error
        homeScenePresneter.presentCharacters(.failure(.unknown))
        
        // update view
        XCTAssertTrue(viewControllerMock.didShowError, "Presenter dosen't update view on error")
        
    }
    
    
}
