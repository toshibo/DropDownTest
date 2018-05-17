//
//  CollectionHeaderView.swift
//  DropDownTest
//
//  Created by Toshi Fujita on 2018/05/16.
//  Copyright © 2018年 toshibo. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    var viewController: ViewController!
    
    func inject(viewController: ViewController) {
        self.viewController = viewController
    }
    
    @IBAction func showDropDown(_ sender: UIButton) {
         viewController.showDropDown(dropDownButton: sender)
        print("DEBUG: ドロップダウンを表示するボタンのframe \(sender.frame)")
    }
    
}

