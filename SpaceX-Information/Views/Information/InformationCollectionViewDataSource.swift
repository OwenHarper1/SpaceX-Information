//
//  InformationCollectionViewDataSource.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 17/11/2021.
//

import UIKit

class InformationCollectionViewDataSource: NSObject, UICollectionViewDataSource {
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
		default: return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		cellFactory.makeCell(at: indexPath)
	}
	
	enum Section: Int, CaseIterable {
		case companyInformation
	}
}
