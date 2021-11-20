//
//  InformationCollectionViewDataSource.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 17/11/2021.
//

import UIKit
import Logic

class InformationCollectionViewDataSource: NSObject, UICollectionViewDataSource {
	typealias Section = InformationViewController.Section
	
	private let cellFactory: InformationCollectionViewCellFactory
	private let viewModel: InformationViewModel
	
	init(cellFactory: InformationCollectionViewCellFactory, viewModel: InformationViewModel) {
		self.cellFactory = cellFactory
		self.viewModel = viewModel
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return Section.allCases.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let section = Section(rawValue: section)
		
		switch section {
		case .companyInformation: return viewModel.companyInformation == nil ? 0 : 1
		case .flights: return viewModel.flights?.count ?? 0
		default: return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return cellFactory.makeCell(at: indexPath)
	}
}
