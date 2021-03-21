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
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var reloadButton: UIButton!
    
    //MARK: - Properties
    var interactor: HomeSceneBusinessLogic?
    var router: HomeSceneRoutingLogic?
    var herosItems = [HomeScene.Search.ViewModel]()
    
    // MARK: - init
    class func instanceFromNib() -> HomeSceneViewController {
        return HomeSceneViewController(nibName: "HomeSceneViewController", bundle: nil)
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        homeSceneView?.collectionView.delegate = self
        homeSceneView?.collectionView.dataSource = self
        homeSceneView.setCollectionViewLayout(animated: false)
        reloadButton.layer.cornerRadius = 8
        navigationController?.delegate = self
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
            self?.homeSceneView?.setCollectionViewLayout(animated: false)
        } completion: { (_) in
            
        }
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    // MARK: - Actions
    @IBAction func didTapReload(_ sender: Any) {
        errorView.isHidden = true
        interactor?.fetchCharacters()
    }
    
    
}

extension HomeSceneViewController: HomeSceneDisplayView {
    func didFetchCharacters(viewModel: [HomeScene.Search.ViewModel]) {
        homeSceneView.isHidden = false
        self.herosItems = viewModel
        self.homeSceneView.reloadCollectionView()
    }
    
    func failedToFetchCharacters(error: Error) {
        errorView.isHidden = false
        homeSceneView.isHidden = true
    }
}

// MARK: - Collection View DataSource
extension HomeSceneViewController :UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return herosItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCharacterCollectionViewCell.identifier, for: indexPath) as?  HomeCharacterCollectionViewCell
        cell?.configure(with: herosItems[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}

//MARK: - Collection View Delegate
extension HomeSceneViewController :UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeSceneView.setSelectedCellFrame(indexPath: indexPath)
        router?.routeToCharacterDetailsWithCharacter(at: indexPath.row)
    }
    
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

//MARK: - Transition Animation Delegate
extension HomeSceneViewController : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return FlipPresentAnimationController(originFrame: homeSceneView.selectedFrame!)
        default:
            return FlipDismissAnimationController(destinationFrame: homeSceneView.selectedFrame!)
        }
    }
}

