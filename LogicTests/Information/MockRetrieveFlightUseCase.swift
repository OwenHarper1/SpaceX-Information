//
//  MockRetrieveFlightUseCase.swift
//  LogicTests
//
//  Created by Owen Harper on 19/11/2021.
//

@testable import Domain

class MockRetrieveFlightUseCase: RetrieveFlightUseCase {
	var result: Result<[Flight], DomainError>!
	
	func execute(completion: @escaping (Result<[Flight], DomainError>) -> ()) {
		completion(result)
	}
}
