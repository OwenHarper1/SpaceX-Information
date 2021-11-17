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
	
	// todo: refactor result handling
	// todo: extract mapping
	public func retrieve(completion: @escaping (Result<CompanyInformation, DomainError>) -> ()) {
		service.retrieve { result in
			switch result {
			case .success(let information):
				completion(.success(CompanyInformation(companyName: information.name,
													   founderName: information.founder,
													   foundingYear: .from(years: information.founded),
													   totalLaunchSites: information.launchSites,
													   unitedStatesDollarValuation: information.valuation)))
			case .failure(let error):
				let newError = ErrorConverter.convert(error)
				completion(.failure(newError))
			}
		}
	}
}
