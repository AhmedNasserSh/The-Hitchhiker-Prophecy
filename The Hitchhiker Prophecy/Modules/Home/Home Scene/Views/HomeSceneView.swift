//
//  HomeSceneView.swift
//  The Hitchhiker Prophecy
//
//  Created by Ahmed Nasser on 21/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import UIKit

class HomeSceneView: UIView {
    //MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var changeLayoutButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    var currentPage = 0
    let collectionMargin = CGFloat(0)
    var itemSpacing = CGFloat(5)
    var currentItem = 0
    var layout :UICollectionViewFlowLayout?
    let cellPeekWidth = CGFloat(10)
    var  currentScrollOffset :CGPoint?
    var selectedFrame : CGRect?
    var selectedIndex :Int = 0
    
    var itemWidth : CGFloat? {
        return max(0, collectionView.frame.size.width - 2 * (itemSpacing + cellPeekWidth))
    }
    var itemHeight: CGFloat? {
        if horizontalOrientiation {
            return self.collectionView.frame.height - 40
        }
        return 250
    }
    var horizontalOrientiation = true {
        didSet {
            setCollectionViewLayout()
        }
    }
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    
    //MARK: Actions
    @IBAction func didTapChangeLayout(_ sender: Any) {
        // change layout oriention
        disableChangeLayoutButton(disable: true)
        horizontalOrientiation = !horizontalOrientiation
    }
    
    //MARK: Events
    func showLoadingView(show:Bool) {
        if show {
            loadingIndicator.startAnimating()
        }else{
            loadingIndicator.stopAnimating()
        }
        disableChangeLayoutButton(disable: show)
    }
    
    func disableChangeLayoutButton(disable:Bool){
        changeLayoutButton.isUserInteractionEnabled = !disable
    }
    
}
// MARK: - UI Setup
extension HomeSceneView {
    private func setupUI() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(contentView)
        collectionView.register(UINib(nibName: "HomeCharacterCollectionViewCell", bundle: nil)
                                , forCellWithReuseIdentifier:HomeCharacterCollectionViewCell.identifier)
        if #available(iOS 13.0, *) {
            loadingIndicator.style = .large
        } else {
            loadingIndicator.style = .whiteLarge
        }
    }
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: String(describing: type(of:self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
}

//MARK: - Collection View Layout Change
extension HomeSceneView {
    //MARK: set the layout for the collection View
    func setCollectionViewLayout(animated:Bool = true) {
        if horizontalOrientiation {
            setHorizontalLayout()
        }else {
            setVerticalLayout()
        }
    }
    
    //MARK: generate the horizontal layout for the collection View
    func setHorizontalLayout(animated:Bool = true) {
        layout = UICollectionViewFlowLayout()
        layout?.scrollDirection = .horizontal
        currentPage = 0
        let leftAndRightInsets = itemSpacing + cellPeekWidth
        layout?.sectionInset = UIEdgeInsets(top: 0, left: leftAndRightInsets, bottom: 0, right: leftAndRightInsets)
        layout?.itemSize = CGSize(width: itemWidth ?? 0, height: itemHeight ?? 0)
        layout?.minimumInteritemSpacing = 0
        layout?.minimumLineSpacing = itemSpacing
        layout?.scrollDirection = .horizontal
        collectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
        animateLayoutChange(animated: animated)
    }
    
    //MARK: generate the vertical layout for the collection View
    func setVerticalLayout(animated:Bool = true) {
        layout = UICollectionViewFlowLayout()
        layout?.scrollDirection = .vertical
        animateLayoutChange(animated: animated)
    }
    
    //MARK: animate collection view layout change
    func animateLayoutChange(animated:Bool = true){
        collectionView.setCollectionViewLayout(layout!, animated: animated)
        disableChangeLayoutButton(disable: false)
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}
//MARK: - Collection View Paging
extension HomeSceneView {
    
    //MARK: on horizontal scrolling center the current cell with respect to peeked cells
    func adjustHorizontalCell(scrollView: UIScrollView,withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) -> CGPoint? {
        if !horizontalOrientiation { return nil}
        let pageWidth = Float((itemWidth ?? 0 ) + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView!.contentSize.width  )
        var newPage = Float(currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? currentPage + 1 :currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        currentPage = Int(newPage)
        return CGPoint (x: CGFloat(newPage * pageWidth) , y: targetContentOffset.pointee.y)
    }
}
// MARK: Transition Animation
extension HomeSceneView  {
    //MARK: save the current selected cell frame  in order to be used in transition animation
    func saveSelectedCellFrame(indexPath: IndexPath) {
        let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
        selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
        selectedIndex = indexPath.row
    }
}
