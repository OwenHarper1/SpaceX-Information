//
//  InformationCollectionViewDiffableDataSource.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 20/11/2021.
//

import UIKit
import Logic

class InformationCollectionViewDiffableDataSource {
	typealias Section = InformationViewController.Section
	typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
	typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
	
	private let collectionView: UICollectionView
	private let cellFactory: InformationCollectionViewCellFactory
	private let viewModel: InformationViewModel
	private var dataSource: DataSource?
	
	init(collectionView: UICollectionView, cellFactory: InformationCollectionViewCellFactory, viewModel: InformationViewModel) {
		self.collectionView = collectionView
		self.cellFactory = cellFactory
		self.viewModel = viewModel
		dataSource = DataSource(collectionView: collectionView) { _, indexPath, model in
			self.cellFactory.makeCell(at: indexPath)
		}
	}
	
	func applySnapshot() {
		DispatchQueue.main.async {
			var snapshot = Snapshot()
			snapshot.appendSections(Section.allCases)
			
			if let companyInformation = self.viewModel.companyInformation {
				snapshot.appendItems([companyInformation], toSection: .companyInformation)
			}
			
			if let flights = self.viewModel.flights {
				snapshot.appendItems(flights, toSection: .flights)
			}
			
			self.dataSource?.apply(snapshot, animatingDifferences: true)
		}
	}
}
