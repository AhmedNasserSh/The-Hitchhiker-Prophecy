//
//  CharachterDetailsSceneInteractorMock.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
@testable import The_Hitchhiker_Prophecy
class CharachterDetailsSceneInteractorMock: CharacterDetailsSceneBusinessLogic {
    var didCallFetchCharacter =  false
    
    func fetchCharacter() {
        didCallFetchCharacter = true
    }
    

    
}
