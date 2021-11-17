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
	private lazy var viewModel = ViewModelFactory.shared.makeInformationViewModel(with: self)
	private var navigator: InformationNavigator?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		decorateInterface()
		
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
	
	// MARK: Actions -
	
	@objc private func presentFilterView() {
		navigator?.presentFilter()
	}
}

extension InformationViewController: InformationViewModelDelegate {
	func retrieved(_ information: CompanyInformation) {
		// todo: handle
		print("retrieved information")
		print(information)
	}
	
	func retrieved(_ error: Error) {
		// todo: handle
		print("retrieved information error")
		print("error")
	}
}
