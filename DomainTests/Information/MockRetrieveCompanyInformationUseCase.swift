//
//  MockRetrieveCompanyInformationUseCase.swift
//  DomainTests
//
//  Created by Owen Harper on 17/11/2021.
//

@testable import Domain

class MockRetrieveCompanyInformationUseCase: RetrieveCompanyInformationUseCase {
	var result: Result<CompanyInformation, Error>!
	
	func execute(completion: @escaping (Result<CompanyInformation, Error>) -> ()) {
		completion(result)
	}
}
