//
//  UICollectionView+Extension.swift
//  MusicApp
//
//  Created by mobven semih on 3.09.2021.
//

import UIKit

extension UICollectionView {
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType.nib,forCellWithReuseIdentifier: cellType.identifier)
    }
    func dequeCell<T:UICollectionViewCell>(cellType:T.Type,indexPath: IndexPath)->T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
}
