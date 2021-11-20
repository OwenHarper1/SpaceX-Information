//
//  InformationNavigator.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 16/11/2021.
//

import UIKit
import Logic
import Domain

class InformationNavigator {
	private let navigationController: UINavigationController?
	
	init(navigationController: UINavigationController?) {
		self.navigationController = navigationController
	}
	
	func presentFilter(viewModel: InformationViewModel) {
		let viewController = FilterViewController(viewModel: viewModel, dismissHandler: {
			self.navigationController?.dismiss(animated: true)
		})
		navigationController?.present(viewController, animated: true)
	}
	
	func presentSocialMedia(for flight: Flight) {
		guard let links = flight.links,
			  !links.article.isNil || !links.webcast.isNil || !links.wikipedia.isNil else { return }
		
		let alert = AlertBuilder()
			.style(.actionSheet)
			.title(.information)
			.message("Access the links below to find out more details about this flight")
			.action(if: !links.article.isNil, style: .custom("Article")) {
				self.open(url: flight.links?.article)
			}
			.action(if: !links.wikipedia.isNil , style: .custom("Wikipedia")) {
				self.open(url: flight.links?.wikipedia)
			}
			.action(if: !links.webcast.isNil, style: .custom("Webcast")) {
				self.open(url: flight.links?.webcast)
			}
			.action(style: .cancel)
			.build()
		
		navigationController?.present(alert, animated: true)
	}
	
	private func open(url: URL?) {
		guard let url = url else { return }
		UIApplication.shared.open(url, options: [:], completionHandler: nil)
	}
}
