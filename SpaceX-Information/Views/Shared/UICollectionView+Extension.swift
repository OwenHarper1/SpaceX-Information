//
//  UICollectionView+Extension.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 17/11/2021.
//

import UIKit

extension UICollectionView {
	func register<T: UICollectionViewCell>(_ cellType: T.Type) {
		let name = cellType.identifier
		register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
	}
	
	func dequeueReusableCell<T: UICollectionViewCell>(ofType type: T.Type, at indexPath: IndexPath) -> T? {
		return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
	}
}
