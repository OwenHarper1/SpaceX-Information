//
//  InformationNavigator.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 16/11/2021.
//

import UIKit
import Logic

class InformationNavigator {
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func presentFilter(viewModel: InformationViewModel) {
		let viewController = FilterViewController(viewModel: viewModel)
//		let filterNavigationController = UINavigationController(rootViewController: viewController)
		navigationController.present(viewController, animated: true)
	}
}
