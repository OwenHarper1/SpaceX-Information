//
//  InformationCollectionViewCellFactory.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 17/11/2021.
//

import UIKit
import Logic

class InformationCollectionViewCellFactory: CellFactory {
	typealias Section = InformationViewController.Section
	
	private let collectionView: UICollectionView
	private let viewModel: InformationViewModel
	
	init(collectionView: UICollectionView, viewModel: InformationViewModel) {
		self.collectionView = collectionView
		self.viewModel = viewModel
		registerCells()
	}
	
	func registerCells() {
		collectionView.register(InformationCompanyCollectionViewCell.self)
		collectionView.register(InformationFlightCollectionViewCell.self)
	}
	
	func makeCell(at indexPath: IndexPath) -> UICollectionViewCell {
		let section = Section(rawValue: indexPath.section)
		
		switch section {
		case .companyInformation: return makeCompanyCell(at: indexPath)
		case .flights: return makeFlightCell(at: indexPath)
		default: return UICollectionViewCell()
		}
	}
	
	private func makeCompanyCell(at indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(ofType: InformationCompanyCollectionViewCell.self, at: indexPath), let companyInformation = viewModel.companyInformation else {
			return UICollectionViewCell()
		}
		
		cell.configure(from: companyInformation)
		
		return cell
	}
	
	private func makeFlightCell(at indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(ofType: InformationFlightCollectionViewCell.self, at: indexPath), let flight = viewModel.flights?[indexPath.row] else {
			return UICollectionViewCell()
		}
		
		cell.configure(from: flight)
		
		return cell
	}
}
