//
//  InformationViewController.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 16/11/2021.
//

import UIKit

class InformationViewController: UIViewController {

	private var navigator: InformationNavigator?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		decorateInterface()
		
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
