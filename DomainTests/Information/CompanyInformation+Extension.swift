//
//  CompanyInformation+Extension.swift
//  DomainTests
//
//  Created by Owen Harper on 17/11/2021.
//

@testable import Domain
import Foundation

extension CompanyInformation {
	static func mock(companyName: String = "Tesla",
					 founderName: String = "Also Elon Musk",
					 foundingYear: Date = .startOfYear2021(),
					 employeeCount: Int = 9500,
					 totalLaunchSites: Int = 1,
					 unitedStatesDollarValuation: Int = 30_000_000_000,
					 companySummary: String = "Make rockets go zoom") -> Self {
		return .init(companyName: companyName,
					 founderName: founderName,
					 foundingYear: foundingYear,
					 employeeCount: employeeCount,
					 totalLaunchSites: totalLaunchSites,
					 unitedStatesDollarValuation: unitedStatesDollarValuation,
					 companySummary: companySummary)
	}
}
