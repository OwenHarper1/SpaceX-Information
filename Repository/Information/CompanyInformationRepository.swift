//
//  CompanyInformationRepository.swift
//  Repository
//
//  Created by Owen Harper on 16/11/2021.
//

import Domain

public class CompanyInformationRepository: Domain.CompanyInformationRepository {
	private let service: CompanyInformationService
	
	public init(service: CompanyInformationService) {
		self.service = service
	}
	
	public func retrieve(completion: @escaping (Result<CompanyInformation, Error>) -> ()) {
		service.retrieve { result in
			switch result {
			case .success(let information):
				completion(.success(CompanyInformation(companyName: information.name,
													   founderName: information.founder,
													   foundingYear: .from(years: information.founded)!, // todo: remove bang, move date handling down to the service layer and parse using the code currently in the .from method
													   totalLaunchSites: information.launchSites,
													   unitedStatesDollarValuation: information.valuation)))
				break // todo: add mapping
			case .failure(let error):
				completion(.failure(error))
				break // todo: implement
			}
		}
	}
}
