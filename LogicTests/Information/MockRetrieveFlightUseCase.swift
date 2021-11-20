//
//  MockRetrieveFlightUseCase.swift
//  LogicTests
//
//  Created by Owen Harper on 19/11/2021.
//

@testable import Domain

class MockRetrieveFlightUseCase: RetrieveFlightUseCase {
	var result: Result<[Flight], DomainError>!
	var retrievalType: FlightRetrievalType!
	
	func execute(retrievalType: FlightRetrievalType, completion: @escaping (Result<[Flight], DomainError>) -> ()) {
		self.retrievalType = retrievalType
		completion(result)
	}
}
