//
//  CompanyInformation.swift
//  Domain
//
//  Created by Owen Harper on 17/11/2021.
//

import Foundation

public struct CompanyInformation: Hashable {
	public let companyName: String
	public let founderName: String
	public let foundingYear: Date?
	public let employeeCount: Int
	public let totalLaunchSites: Int
	public let unitedStatesDollarValuation: Int
	public let companySummary: String
	
	public init(companyName: String, founderName: String, foundingYear: Date?, employeeCount: Int, totalLaunchSites: Int, unitedStatesDollarValuation: Int, companySummary: String) {
		self.companyName = companyName
		self.founderName = founderName
		self.foundingYear = foundingYear
		self.employeeCount = employeeCount
		self.totalLaunchSites = totalLaunchSites
		self.unitedStatesDollarValuation = unitedStatesDollarValuation
		self.companySummary = companySummary
	}
}
