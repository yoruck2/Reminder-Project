//
//  CollectionView+.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import UIKit

extension UICollectionView {
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 15
        let cellSpacing: CGFloat = 15
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - cellSpacing
        layout.itemSize = CGSize(width: width / 2, height: width / 2 * 0.5)
        layout.scrollDirection = .vertical

        layout.sectionInset = UIEdgeInsets(top: sectionSpacing,
                                           left: sectionSpacing,
                                           bottom: sectionSpacing,
                                           right: sectionSpacing)
        return layout
    }
}
