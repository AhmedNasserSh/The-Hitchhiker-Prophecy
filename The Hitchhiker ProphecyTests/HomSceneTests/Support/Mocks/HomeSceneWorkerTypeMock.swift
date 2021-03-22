//
//  HomeSceneWorkerTypeMock.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
@testable import The_Hitchhiker_Prophecy
class HomeSceneWorkerTypeMock: HomeWorkerType {
    let mockHelper = MockHelper<Characters.Search.Output>()
    
    func getCharacters(_ input: Characters.Search.Input, completion: @escaping (HomeScene.Search.Response) -> Void) {
         mockHelper.getMockup(jsonFileName: "CharactersResponseData", completion: completion)
    }
}
