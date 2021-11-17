//
//  CompanyInformation.swift
//  Domain
//
//  Created by Owen Harper on 17/11/2021.
//

import Foundation

public struct CompanyInformation {
	let companyName: String
	let founderName: String
	let foundingYear: Date?
	let totalLaunchSites: Int
	let unitedStatesDollarValuation: Int
	
	public init(companyName: String, founderName: String, foundingYear: Date?, totalLaunchSites: Int, unitedStatesDollarValuation: Int) {
		self.companyName = companyName
		self.founderName = founderName
		self.foundingYear = foundingYear
		self.totalLaunchSites = totalLaunchSites
		self.unitedStatesDollarValuation = unitedStatesDollarValuation
	}
}
