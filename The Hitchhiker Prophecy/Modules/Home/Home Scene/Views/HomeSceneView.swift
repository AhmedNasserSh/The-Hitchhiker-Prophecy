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
    
    //MARK: - Properties
    var currentPage = 0
    let collectionMargin = CGFloat(0)
    var itemSpacing = CGFloat(5)
    var currentItem = 0
    var layout :UICollectionViewFlowLayout?
    let cellPeekWidth = CGFloat(10)
    var  currentScrollOffset :CGPoint?
    var itemWidth : CGFloat? {
        return max(0, collectionView.frame.size.width - 2 * (itemSpacing + cellPeekWidth))
    }
    var itemHeight: CGFloat? {
        if horizontalOrientiation {
            return self.collectionView.frame.height - 40
        }
        return 200
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
        changeLayoutButton.isUserInteractionEnabled = false
        horizontalOrientiation = !horizontalOrientiation
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
    }
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: String(describing: type(of:self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    func initCollectionViewLayout() {
        setCollectionViewLayout()
        collectionView.collectionViewLayout = layout!
        animateLayoutChange()
    }
}

//MARK: - Collection View Layout Change
extension HomeSceneView {
    func setCollectionViewLayout() {
        if horizontalOrientiation {
            setHorizontalLayout()
        }else {
            setVerticalLayout()
        }
    }
    
    func setHorizontalLayout() {
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
        animateLayoutChange()
    }
    
    func setVerticalLayout() {
        layout = UICollectionViewFlowLayout()
        layout?.scrollDirection = .vertical
        animateLayoutChange()
    }

    func animateLayoutChange(){
        collectionView.setCollectionViewLayout(layout!, animated: true)
        self.changeLayoutButton.isUserInteractionEnabled = true
    }
}
//MARK: - Collection View Paging
extension HomeSceneView {
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
        print(CGFloat(newPage * pageWidth) ,targetXContentOffset,newPage)
        return CGPoint (x: CGFloat(newPage * pageWidth) , y: targetContentOffset.pointee.y)
    }
}
