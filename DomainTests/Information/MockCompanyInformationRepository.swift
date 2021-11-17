//
//  MockCompanyInformationRepository.swift
//  DomainTests
//
//  Created by Owen Harper on 17/11/2021.
//

@testable import Domain

class MockCompanyInformationRepository: CompanyInformationRepository {
	var result: Result<CompanyInformation, DomainError>!
	
	func retrieve(completion: @escaping (Result<CompanyInformation, DomainError>) -> ()) {
		completion(result)
	}
}
