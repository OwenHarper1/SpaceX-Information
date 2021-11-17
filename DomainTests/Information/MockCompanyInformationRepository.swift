//
//  MockCompanyInformationRepository.swift
//  DomainTests
//
//  Created by Owen Harper on 17/11/2021.
//

@testable import Domain

class MockCompanyInformationRepository: CompanyInformationRepository {
	var result: Result<CompanyInformation, Error>!
	
	func retrieve(completion: @escaping (Result<CompanyInformation, Error>) -> ()) {
		completion(result)
	}
}
