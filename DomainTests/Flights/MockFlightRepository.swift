//
//  MockFlightRepository.swift
//  DomainTests
//
//  Created by Owen Harper on 19/11/2021.
//

@testable import Domain

class MockFlightRepository: FlightRepository {
	var result: Result<[Flight], DomainError>!
	
	func retrieve(completion: @escaping (Result<[Flight], DomainError>) -> ()) {
		completion(result)
	}
}
