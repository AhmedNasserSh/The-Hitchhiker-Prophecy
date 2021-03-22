//
//  CharachterDetailsSceneDisplayViewMock.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
@testable import The_Hitchhiker_Prophecy
class CharachterDetailsSceneDisplayViewMock : CharacterDetailsSceneDisplayLogic {
    var interactor: CharacterDetailsSceneBusinessLogic?
    var viewModel : CharacterDetailsScene.FetchCharacter.ViewModel?
    
    func didFetchCharacter(viewModel: CharacterDetailsScene.FetchCharacter.ViewModel) {
        self.viewModel = viewModel
    }
    
}
