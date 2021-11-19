//
//  MockFlightService.swift
//  RepositoryTests
//
//  Created by Owen Harper on 19/11/2021.
//

@testable import Repository

class MockFlightService: FlightService {
	var result: Result<PaginationContainer<[FlightResponse]>, ServiceError>!
	
	func retrieve(completion: @escaping (Result<PaginationContainer<[FlightResponse]>, ServiceError>) -> ()) {
		completion(result)
	}
}
