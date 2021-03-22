//
//  HomeSceneDisplayViewMock.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
@testable import The_Hitchhiker_Prophecy
class HomeSceneDisplayViewMock : HomeSceneDisplayView {
    var interactor: HomeSceneBusinessLogic?
    var router: HomeSceneRoutingLogic?
    var didShowError = false
    var viewModel =  [HomeScene.Search.ViewModel]()
    
    func didFetchCharacters(viewModel: [HomeScene.Search.ViewModel]) {
        self.viewModel = viewModel
    }
    
    func failedToFetchCharacters(error: Error) {
        didShowError = true
    }
    
    
}
