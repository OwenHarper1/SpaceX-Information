//
//  MockRetrieveCompanyInformationUseCase.swift
//  LogicTests
//
//  Created by Owen Harper on 17/11/2021.
//

@testable import Domain

class MockRetrieveCompanyInformationUseCase: RetrieveCompanyInformationUseCase {
	var result: Result<CompanyInformation, DomainError>!
	
	func execute(completion: @escaping (Result<CompanyInformation, DomainError>) -> ()) {
		completion(result)
	}
}
