//
//  CompanyInformationRepository.swift
//  Repository
//
//  Created by Owen Harper on 16/11/2021.
//

import Domain

// todo: extract
public protocol CompanyInformationService {
	func retrieveInformation() // todo: implement
}

public class CompanyInformationRepository: Domain.CompanyInformationRepository {
	private let service: CompanyInformationService
	
	public init(service: CompanyInformationService) {
		self.service = service
	}
	
	public func retrieve(completion: @escaping (Result<CompanyInformation, Error>) -> ()) {
		// todo: implement
	}
}
