//
//  CharachterDetailsScenePresenterMock.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
@testable import The_Hitchhiker_Prophecy

class CharachterDetailsScenePresenterMock :CharacterDetailsScenePresentationLogic{
    var displayView: CharacterDetailsSceneDisplayLogic?
    var didDisplayCharcter = false
    
    func presentCharacter(_ response: CharacterDetailsScene.FetchCharacter.Response) {
        didDisplayCharcter = true
    }
    
}
