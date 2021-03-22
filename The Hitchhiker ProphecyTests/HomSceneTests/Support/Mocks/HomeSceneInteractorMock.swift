//
//  HomeSceneInteractorMock.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
@testable import The_Hitchhiker_Prophecy
class HomeSceneInteractorMock: HomeSceneBusinessLogic {
    var worker: HomeWorkerType
    
    var presenter: HomeScenePresentationLogic
    
    var didCallFetchCharacters = false
    
    init() {
        worker = HomeSceneWorkerTypeMock()
        presenter = HomeScenePresneterMock()
    }
    
    func fetchCharacters() {
        didCallFetchCharacters = true
    }
    
    
}
