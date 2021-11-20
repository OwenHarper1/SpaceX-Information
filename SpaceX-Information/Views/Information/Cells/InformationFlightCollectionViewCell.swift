//
//  InformationFlightCollectionViewCell.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 19/11/2021.
//

import UIKit
import Domain
import Kingfisher

class InformationFlightCollectionViewCell: UICollectionViewCell {
	@IBOutlet private weak var missionLabel: UILabel!
	@IBOutlet private weak var dateLabel: UILabel!
	@IBOutlet private weak var rocketLabel: UILabel!
	@IBOutlet private weak var daysLabel: UILabel!
	
	@IBOutlet private weak var missionValueLabel: UILabel!
	@IBOutlet private weak var dateValueLabel: UILabel!
	@IBOutlet private weak var rocketValueLabel: UILabel!
	@IBOutlet private weak var daysValueLabel: UILabel!
	
	@IBOutlet private weak var patchImage: UIImageView!
	@IBOutlet private weak var successImage: UIImageView!
	
	@IBOutlet private weak var mediaAvailableContainer: UIView!
	
	func configure(from flight: Flight) {
		patchImage.kf.setImage(with: flight.missionPatchLowResolution)
		
		missionValueLabel.text = flight.name
		dateValueLabel.text = flight.launchDateTime.toReadableFormat(.dayMonthYear)
		
		rocketValueLabel.isHidden = flight.rocket == nil
		rocketLabel.isHidden = flight.rocket == nil
		
		if let rocket = flight.rocket {
			rocketValueLabel.text = "\(rocket.name) / \(rocket.type)"
		}
		
		daysValueLabel.text = (flight.daysToLaunch).withCommas()
		
		successImage.tintColor = successTint(for: flight.launchDidSucceed)
		successImage.image = successImage(for: flight.launchDidSucceed)
		
		mediaAvailableContainer.isHidden = !(flight.links?.linksPresent ?? false)
	}
	
	private func successTint(for successStatus: Bool?) -> UIColor? {
		switch successStatus {
		case true: return .systemGreen
		case false: return .systemRed
		case .none: return .systemOrange
		default: return nil
		}
	}
	
	private func successImage(for successStatus: Bool?) -> UIImage? {
		switch successStatus {
		case true: return .success
		case false: return .failure
		case .none: return .question
		default: return nil
		}
	}
}

fileprivate extension UIImage {
	static let success = UIImage(systemName: "checkmark.circle.fill")
	static let failure = UIImage(systemName: "xmark.circle.fill")
	static let question = UIImage(systemName: "questionmark.circle.fill")
}
