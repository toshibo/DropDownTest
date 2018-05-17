//
//  ViewController.swift
//  DropDownTest
//
//  Created by Toshi Fujita on 2018/05/15.
//  Copyright © 2018年 toshibo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var dropDownButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as! CollectionHeaderView
        view.inject(viewController: self)
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height: CGFloat = 320
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width / 3.0 - 5 * 2.0
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func showDropDown(dropDownButton: UIButton) {
        self.dropDownButton = dropDownButton
        let dropdown = TableViewController()
        dropdown.transitioningDelegate = self
        dropdown.modalPresentationStyle = .custom
        dropdown.view.backgroundColor = .white
        
        self.present(dropdown, animated: true, completion: nil)
        
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let dropDownController = DropDownPresentationController(presentedViewController: presented, presenting: presenting)
        dropDownController.targetFrame = self.dropDownButton.frame
        print("DEBUG: sortButton frame \(self.dropDownButton.frame)")
        return dropDownController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DropDownAnimator(direction: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DropDownAnimator(direction: .dismiss)
    }
}
