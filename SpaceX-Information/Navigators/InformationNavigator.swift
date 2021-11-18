//
//  InformationNavigator.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 16/11/2021.
//

import UIKit

class InformationNavigator {
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func presentFilter() {
		let viewController = FilterViewController()
		let filterNavigationController = UINavigationController(rootViewController: viewController)
		navigationController.present(filterNavigationController, animated: true)
	}
}
