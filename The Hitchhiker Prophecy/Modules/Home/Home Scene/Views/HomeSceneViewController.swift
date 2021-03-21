//
//  HomeSceneViewController.swift
//  The Hitchhiker Prophecy
//
//  Created by Mohamed Matloub on 6/10/20.
//  Copyright © 2020 SWVL. All rights reserved.
//

import UIKit

class HomeSceneViewController: UIViewController {
    //MARK: - Otulets
    @IBOutlet weak var homeSceneView: HomeSceneView!
    
    //MARK: - Properties
    var interactor: HomeSceneBusinessLogic?
    var router: HomeSceneRoutingLogic?
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        homeSceneView?.collectionView.delegate = self
        homeSceneView?.collectionView.dataSource = self
        homeSceneView.initCollectionViewLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchCharacters()
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // handle device oriention
        coordinator.animate { [weak self] (_) in
            self?.homeSceneView?.setCollectionViewLayout()
        } completion: { (_) in
            
        }
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    // MARK: - init
    class func instanceFromNib() -> HomeSceneViewController {
        return HomeSceneViewController(nibName: "HomeSceneViewController", bundle: nil)
    }
}

extension HomeSceneViewController: HomeSceneDisplayView {
    func didFetchCharacters(viewModel: [HomeScene.Search.ViewModel]) {
        // TODO: Implement
    }
    
    func failedToFetchCharacters(error: Error) {
        // TODO: Implement
    }
}
// MARK: - Collection View DataSource
extension HomeSceneViewController :UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCharacterCollectionViewCell.identifier, for: indexPath) as?  HomeCharacterCollectionViewCell
        cell?.configure(with: HomeScene.Search.ViewModel(name: "\(indexPath.row)", desc: "", imageUrl: "", comics: "", series: "", stories: "", events: ""))
        return cell ?? UICollectionViewCell()
    }
}
//MARK: - Collection View Delegate
extension HomeSceneViewController :UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.homeSceneView.itemWidth ?? 0, height:self.homeSceneView.itemHeight ?? 0)
    }
}
// MARK: - ScrollViewDelegate
extension HomeSceneViewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        homeSceneView.currentScrollOffset = scrollView.contentOffset
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentPoint = homeSceneView?.adjustHorizontalCell(scrollView:scrollView,withVelocity: velocity, targetContentOffset: targetContentOffset)
        targetContentOffset.pointee = currentPoint ?? targetContentOffset.pointee
    }
}
