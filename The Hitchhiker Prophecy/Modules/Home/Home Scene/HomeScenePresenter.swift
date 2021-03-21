//
//  HomeScenePresenter.swift
//  The Hitchhiker Prophecy
//
//  Created by Mohamed Matloub on 6/13/20.
//  Copyright © 2020 SWVL. All rights reserved.
//

import Foundation

class HomeScenePresneter: HomeScenePresentationLogic {
    weak var displayView: HomeSceneDisplayView?
    
    init(displayView: HomeSceneDisplayView) {
        self.displayView = displayView
    }
    
    func presentCharacters(_ response: HomeScene.Search.Response) {
        switch response {
        case .success(let output):
            let viewModel = map(output: output)
            displayView?.didFetchCharacters(viewModel: viewModel)
        case .failure(let error) :
            displayView?.failedToFetchCharacters(error: error)
        }
    }
    
    private func map(output:Characters.Search.Output) -> [HomeScene.Search.ViewModel] {
        let results = output.data
        let viewModels = results.results.map { (charcter) -> HomeScene.Search.ViewModel in
            let comics = charcter.comics.items.map{$0.name}.joined(separator: ",")
            let series = charcter.series.items.map{$0.name}.joined(separator: ",")
            let stories = charcter.stories.items.map{$0.name}.joined(separator: ",")
            let events = charcter.events.items.map{$0.name}.joined(separator: ",")
            let imageURL = charcter.thumbnail.path + "/" + Characters.Search.Character.ThumbnailOrientation.portrait.rawValue + charcter.thumbnail.thumbnailExtension
            
            let viewModel = HomeScene.Search.ViewModel(name: charcter.name,
                                                       desc: charcter.resultDescription,
                                                       imageUrl: imageURL,
                                                       comics: comics,
                                                       series: series,
                                                       stories: stories,
                                                       events: events)
            return viewModel
            
        }
        return viewModels
    }
}
