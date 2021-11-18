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
		return AttributedStringBuilder()
			.text(companyInformation.companyName, with: .majorStyling)
			.text(" was founded by ", with: .minorStyling)
			.text(companyInformation.founderName, with: .majorStyling)
			.optionalText(formatFoundingYear(from: companyInformation.foundingYear), with: .minorStyling)
			.fullStop(with: .minorStyling)
			.newLine(count: 2)
			.text("It now has ", with: .minorStyling)
			.int(companyInformation.employeeCount, with: .majorStyling)
			.text(" employees, ", with: .minorStyling)
			.int(companyInformation.totalLaunchSites, with: .majorStyling)
			.text(" launch sites, and is valued at ", with: .minorStyling)
			.currency(companyInformation.unitedStatesDollarValuation, symbol: "$", with: .currencyStyling)
			.build()
	}
	
	private func formatFoundingYear(from date: Date?) -> String? {
		guard let date = date, let formattedYear = date.toYear() else { return nil }
		return "in \(formattedYear)"
	}
}

fileprivate extension Array where Element == AttributedStringBuilder.Property {
	static let majorStyling: [AttributedStringBuilder.Property] = [
		.font(.systemFont(ofSize: 18, weight: .semibold)),
		.colour(.tintColor)
	]
	
	static let minorStyling: [AttributedStringBuilder.Property] = [
		.font(.systemFont(ofSize: 16, weight: .regular)),
		.colour(.secondaryLabel)
	]
	
	static let currencyStyling: [AttributedStringBuilder.Property] = [
		.font(.systemFont(ofSize: 16, weight: .medium)),
		.colour(.systemGreen)
	]
}
