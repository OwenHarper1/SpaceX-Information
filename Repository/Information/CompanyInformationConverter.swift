//
//  CompanyInformationConverter.swift
//  Repository
//
//  Created by Owen Harper on 17/11/2021.
//

import Domain

class CompanyInformationConverter {
	static func convert(_ companyInformationResponse: CompanyInformationResponse) -> CompanyInformation {
		return CompanyInformation(companyName: companyInformationResponse.name,
								  founderName: companyInformationResponse.founder,
								  foundingYear: .from(years: companyInformationResponse.founded),
								  employeeCount: companyInformationResponse.employees,
								  totalLaunchSites: companyInformationResponse.launchSites,
								  unitedStatesDollarValuation: companyInformationResponse.valuation)
	}
}
