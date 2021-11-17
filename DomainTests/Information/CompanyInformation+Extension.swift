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
					 totalLaunchSites: Int = 1,
					 unitedStatesDollarValuation: Int = 30_000_000_000) -> Self {
		return .init(companyName: companyName,
					 founderName: founderName,
					 foundingYear: foundingYear,
					 totalLaunchSites: totalLaunchSites,
					 unitedStatesDollarValuation: unitedStatesDollarValuation)
	}
}

// todo: extract
extension Date {
	static func startOfYear2021() -> Date {
		return Date(timeIntervalSinceReferenceDate: 631152000)
	}
}
