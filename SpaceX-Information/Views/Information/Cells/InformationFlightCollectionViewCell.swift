//
//  InformationFlightCollectionViewCell.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 19/11/2021.
//

import UIKit
import Domain

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
	
	func configure(from flight: Flight) {
		missionValueLabel.text = flight.name
		dateValueLabel.text = flight.launchDateTime.toReadableFormat(.yearMonthDay)
		
		rocketValueLabel.isHidden = flight.rocket == nil
		rocketLabel.isHidden = flight.rocket == nil
		
		if let rocket = flight.rocket {
			rocketValueLabel.text = "\(rocket.name) / \(rocket.type)"
		}
		
		successImage.tintColor = flight.launchDidSucceed ? .systemGreen : .systemRed
		successImage.image = flight.launchDidSucceed ? .success : .failure
		
		daysValueLabel.text = (-flight.daysToLaunch).withCommas()
	}
}

fileprivate extension UIImage {
	static let success = UIImage(systemName: "checkmark.circle.fill")
	static let failure = UIImage(systemName: "xmark.circle.fill")
}
