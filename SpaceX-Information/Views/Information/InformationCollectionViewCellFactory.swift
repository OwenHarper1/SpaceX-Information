//
//  InformationCollectionViewCellFactory.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 17/11/2021.
//

import UIKit

class InformationCollectionViewCellFactory: CellFactory {
	typealias Section = InformationCollectionViewDataSource.Section
	
	private let collectionView: UICollectionView
	private let viewModel: InformationViewModel
	
	init(collectionView: UICollectionView, viewModel: InformationViewModel) {
		self.collectionView = collectionView
		self.viewModel = viewModel
		registerCells()
	}
	
	func registerCells() {
		collectionView.register(InformationCompanyCollectionViewCell.self)
	}
	
	func makeCell(at indexPath: IndexPath) -> UICollectionViewCell {
		let section = Section(rawValue: indexPath.section)
		
		switch section {
		case .companyInformation: return makeCompanyCell(at: indexPath)
		default: return UICollectionViewCell()
		}
	}
	
	private func makeCompanyCell(at indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(ofType: InformationCompanyCollectionViewCell.self, at: indexPath), let companyInformation = viewModel.companyInformation else {
			return UICollectionViewCell()
		}
		
		cell.configure(from: companyInformation)
		// todo: add setup
		return cell
	}
}
