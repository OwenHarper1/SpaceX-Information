//
//  InformationCollectionViewCellDelegate.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 20/11/2021.
//

import UIKit
import Logic

class InformationCollectionViewCellDelegate: NSObject, UICollectionViewDelegate {
	typealias Section = InformationViewController.Section
	
	private let viewModel: InformationViewModel
	private let navigator: InformationNavigator
	
	init(viewModel: InformationViewModel, navigator: InformationNavigator) {
		self.viewModel = viewModel
		self.navigator = navigator
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		guard let count = viewModel.flights?.count, count > 0,
			  indexPath == IndexPath(item: count - 1, section: Section.flights.rawValue) else { return }
		
		viewModel.loadFlightInformation()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let section = Section(rawValue: indexPath.section),
			  section == .flights,
			  let flight = viewModel.flights?[indexPath.row] else { return }
		
		navigator.presentSocialMedia(for: flight)
	}
}
