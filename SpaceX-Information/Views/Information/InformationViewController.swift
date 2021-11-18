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
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
	
	private lazy var viewModel = ViewModelFactory.shared.makeInformationViewModel(with: self)
	private lazy var cellFactory = InformationCollectionViewCellFactory(collectionView: collectionView, viewModel: viewModel)
	private lazy var dataSource = InformationCollectionViewDataSource(cellFactory: cellFactory, viewModel: viewModel)
	private var navigator: InformationNavigator?
	
	private var state: State = .loading {
		didSet {
			switch state {
			case .loading:
				activityIndicator.startAnimating()
				collectionView.isUserInteractionEnabled = false
			case .loaded:
				activityIndicator.stopAnimating()
				collectionView.isUserInteractionEnabled = true
			}
		}
	}
	
	// MARK: View Lifecycle -
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		decorateInterface()
		setUpCollectionView()
		
		viewModel.load()
		state = .loading
		
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
	
	// MARK: State -
	
	enum State {
		case loading
		case loaded
	}
}

extension InformationViewController: InformationViewModelDelegate {
	func retrievedInformation() {
		DispatchQueue.main.async {
			self.collectionView.reloadSections(IndexSet(integer: 0))
			self.state = .loaded
		}
	}
	
	func retrieved(_ error: DomainError) {
		DispatchQueue.main.async {
			self.state = .loaded
			
			let alert = AlertBuilder()
				.title(.ohNo)
				.message(.custom(self.generateContextualMessage(for: error)))
				.action(style: .cancel)
				.action(style: .tryAgain) {
					self.state = .loading
					self.viewModel.load()
				}
				.build()
			
			self.present(alert, animated: true)
		}
	}
	
	private func generateContextualMessage(for error: DomainError) -> String {
		switch error {
		case .remoteError, .unrecoverableError: return "Oh no! There seems to be a problem loading this resource ❌. Please try later!"
		case .noInternetConnection: return "Oh no! It appears you're not currently connected to the internet 🤔. Please check your connection and try again!"
		}
	}
}
