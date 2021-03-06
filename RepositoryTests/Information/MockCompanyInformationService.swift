//
//  MockCompanyInformationService.swift
//  RepositoryTests
//
//  Created by Owen Harper on 17/11/2021.
//

@testable import Repository

class MockCompanyInformationService: CompanyInformationService {
	var result: Result<CompanyInformationResponse, ServiceError>!
	
	func retrieve(completion: @escaping (Result<CompanyInformationResponse, ServiceError>) -> ()) {
		completion(result)
	}
}
