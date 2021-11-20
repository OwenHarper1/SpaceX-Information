//
//  MockFlightRepository.swift
//  DomainTests
//
//  Created by Owen Harper on 19/11/2021.
//

@testable import Domain

class MockFlightRepository: FlightRepository {
	var result: Result<[Flight], DomainError>!
	var retrievalType: FlightRetrievalType!
	
	func retrieve(retrievalType: FlightRetrievalType, completion: @escaping (Result<[Flight], DomainError>) -> ()) {
		self.retrievalType = retrievalType
		completion(result)
	}
}
