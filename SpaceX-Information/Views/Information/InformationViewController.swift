//
//  InformationViewController.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 16/11/2021.
//

import UIKit
import Configuration
import Logic
import Domain

class InformationViewController: UIViewController {
	@IBOutlet private weak var collectionView: UICollectionView!
	
	private lazy var viewModel = ViewModelFactory.shared.makeInformationViewModel(with: self)
	private lazy var cellFactory = InformationCollectionViewCellFactory(collectionView: collectionView, viewModel: viewModel)
	private lazy var dataSource = InformationCollectionViewDataSource(cellFactory: cellFactory, viewModel: viewModel)
	private var navigator: InformationNavigator?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		decorateInterface()
		setUpCollectionView()
		
		viewModel.load()
		
		guard let navigationController = navigationController else { return }
		
		navigator = .init(navigationController: navigationController)
    }
	
	// MARK: Set Up -
	
	private func decorateInterface() {
		title = "SpaceX"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let filterButton = UIBarButtonItem(image: .filterIcon, style: .plain, target: self, action: #selector(presentFilterView))
		navigationItem.rightBarButtonItem = filterButton
	}
	
	private func setUpCollectionView() {
		let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
		let layout = UICollectionViewCompositionalLayout.list(using: configuration)
		collectionView.collectionViewLayout = layout
		collectionView.dataSource = dataSource
	}
	
	// MARK: Actions -
	
	@objc private func presentFilterView() {
		navigator?.presentFilter()
	}
	
	// MARK: Section -
	
	enum Section: Int, CaseIterable {
		case companyInformation
	}
}

extension InformationViewController: InformationViewModelDelegate {
	func retrievedInformation() {
		collectionView.forceReloadSections(IndexSet(integer: 0))
	}
	
	func retrieved(_ error: DomainError) {
		// todo: handle
		print("retrieved information error")
		print("error")
	}
}
