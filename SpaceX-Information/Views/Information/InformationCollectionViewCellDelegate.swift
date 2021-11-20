//
//  InformationCollectionViewCellDelegate.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 20/11/2021.
//

import UIKit

class InformationCollectionViewCellDelegate: NSObject, UICollectionViewDelegate {
	typealias Section = InformationViewController.Section
	
	private let viewModel: InformationViewModel
	
	init(viewModel: InformationViewModel) {
		self.viewModel = viewModel
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		guard let count = viewModel.flights?.count, count > 0,
			  indexPath == IndexPath(item: count - 1, section: Section.flights.rawValue) else { return }
		
		viewModel.loadFlightInformation()
	}
}
