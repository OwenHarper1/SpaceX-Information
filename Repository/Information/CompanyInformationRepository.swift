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
	
	public func retrieve(completion: @escaping (Result<CompanyInformation, DomainError>) -> ()) {
		service.retrieve {
			$0.map(CompanyInformationConverter.convert)
				.mapError(ErrorConverter.convert)
				.handle(with: completion)
		}
	}
}
