//
//  CompanyInformation.swift
//  Domain
//
//  Created by Owen Harper on 17/11/2021.
//

import Foundation

public struct CompanyInformation {
	public let companyName: String
	public let founderName: String
	public let foundingYear: Date?
	public let totalLaunchSites: Int
	public let unitedStatesDollarValuation: Int
	
	public init(companyName: String, founderName: String, foundingYear: Date?, totalLaunchSites: Int, unitedStatesDollarValuation: Int) {
		self.companyName = companyName
		self.founderName = founderName
		self.foundingYear = foundingYear
		self.totalLaunchSites = totalLaunchSites
		self.unitedStatesDollarValuation = unitedStatesDollarValuation
	}
}
