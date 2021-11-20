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
	private var cellFactory: InformationCollectionViewCellFactory?
	private var dataSource: InformationCollectionViewDiffableDataSource?
	private var delegate: InformationCollectionViewCellDelegate?
	private var navigator: InformationNavigator?
	
	private var state: State = .loading {
		didSet {
			DispatchQueue.main.async {
				switch self.state {
				case .loading:
					self.activityIndicator.startAnimating()
					self.collectionView.isUserInteractionEnabled = false
				case .loaded:
					self.activityIndicator.stopAnimating()
					self.collectionView.isUserInteractionEnabled = true
				}
			}
		}
	}
	
	// MARK: View Lifecycle -
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		decorateInterface()
		setUpCollectionView()
		
		viewModel.loadCompanyInformation()
		viewModel.loadFlightInformation()
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
		
		let cellFactory = InformationCollectionViewCellFactory(collectionView: collectionView, viewModel: viewModel)
		let dataSource = InformationCollectionViewDiffableDataSource(collectionView: collectionView, cellFactory: cellFactory, viewModel: viewModel)
		let delegate = InformationCollectionViewCellDelegate(viewModel: viewModel)
		
		self.cellFactory = cellFactory
		self.dataSource = dataSource
		self.delegate = delegate
		
		collectionView.collectionViewLayout = layout
		collectionView.delegate = delegate
	}
	
	// MARK: Actions -
	
	@objc private func presentFilterView() {
		navigator?.presentFilter(viewModel: viewModel)
	}
	
	// MARK: Section -
	
	enum Section: Int, CaseIterable {
		case companyInformation
		case flights
		
		var indexSet: IndexSet { IndexSet(integer: rawValue) }
	}
	
	// MARK: State -
	
	enum State: Int {
		case loading
		case loaded
	}
}

extension InformationViewController: InformationViewModelDelegate {
	func retrievedInformation() {
		dataSource?.applySnapshot()
		state = .loaded
	}
	
	func retrieved(informationError error: DomainError) {
		DispatchQueue.main.async {
			self.state = .loaded
			
			let alert = AlertBuilder()
				.title(.ohNo)
				.message(.custom(self.generateContextualMessage(for: error, problemArea: "company information")))
				.action(style: .cancel)
				.action(style: .tryAgain) {
					self.state = .loading
					self.viewModel.loadCompanyInformation()
				}
				.build()
			
			self.present(alert, animated: true)
		}
	}
	
	func retrievedFlights() {
		dataSource?.applySnapshot()
	}
	
	func retrieved(flightError error: DomainError) {
		DispatchQueue.main.async {
			let alert = AlertBuilder()
				.title(.ohNo)
				.message(.custom(self.generateContextualMessage(for: error, problemArea: "flights")))
				.action(style: .cancel)
				.action(style: .tryAgain) {
					self.state = .loading
					self.viewModel.loadFlightInformation()
				}
				.build()
			
			self.present(alert, animated: true)
		}
	}
	
	private func generateContextualMessage(for error: DomainError, problemArea: String) -> String {
		switch error {
		case .remoteError, .unrecoverableError: return "Oh no! There seems to be a problem loading \(problemArea) ❌. Please try later!"
		case .noInternetConnection: return "Oh no! It appears you're not currently connected to the internet 🤔. Please check your connection and try again!"
		}
	}
}
