//
//  InformationCompanyCollectionViewCell.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 17/11/2021.
//

import UIKit
import Domain

class InformationCompanyCollectionViewCell: UICollectionViewCell {
	@IBOutlet private weak var informationLabel: UILabel!
	
	func configure(from companyInformation: CompanyInformation) {
		informationLabel.attributedText = makeAttributedString(from: companyInformation)
	}
	
	private func makeAttributedString(from companyInformation: CompanyInformation) -> NSAttributedString {
		let majorFontSize: CGFloat = 20
		let minorFontSize: CGFloat = 17
		let majorFontWeight: UIFont.Weight = .semibold
		let minorFontWeight: UIFont.Weight = .light
//		T##[NSAttributedString.Key : Any]?
		var initialString = NSMutableAttributedString(string: companyInformation.companyName, attributes: [
			.font: UIFont.systemFont(ofSize: majorFontSize, weight: majorFontWeight),
			.foregroundColor: UIColor.tintColor
		])
		
		var foundedByPrelude = NSAttributedString(string: " was founded by ", attributes: [
			.font: UIFont.systemFont(ofSize: minorFontSize, weight: minorFontWeight)
		])
		
		var foundedByText = NSAttributedString(string: companyInformation.founderName, attributes: [
			.font: UIFont.systemFont(ofSize: majorFontSize, weight: majorFontWeight),
			.foregroundColor: UIColor.tintColor
			
		])
		
		var foundedInText: NSAttributedString?
		
		if let foundingDate = companyInformation.foundingYear, let foundingYear = foundingDate.toYear() {
			foundedInText = NSAttributedString(string: " in \(foundingYear)", attributes: [
				.font: UIFont.systemFont(ofSize: minorFontSize, weight: minorFontWeight)
			])
		}
		
		
		
		initialString.append(foundedByPrelude)
		initialString.append(foundedByText)
		
		if let foundedInText = foundedInText {
			initialString.append(foundedInText)
		}
		
		
		return initialString
	}
}
