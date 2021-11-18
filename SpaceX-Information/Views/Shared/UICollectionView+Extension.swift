//
//  UICollectionView+Extension.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 17/11/2021.
//

import UIKit

extension UICollectionView {
	func forceReloadSections(_ indexSet: IndexSet) {
		DispatchQueue.main.async {
			self.reloadSections(indexSet)
		}
	}
}
