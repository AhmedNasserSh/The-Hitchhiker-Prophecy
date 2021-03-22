//
//  HomeScenePresneterMock.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
@testable import The_Hitchhiker_Prophecy

class HomeScenePresneterMock :HomeScenePresentationLogic{
    var displayView: HomeSceneDisplayView?
    var didPresentCharcters  = false
    
    func presentCharacters(_ response: HomeScene.Search.Response) {
        didPresentCharcters = true
    }
    
    
}
