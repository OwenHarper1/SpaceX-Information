//
//  MockFlightService.swift
//  RepositoryTests
//
//  Created by Owen Harper on 19/11/2021.
//

@testable import Repository

class MockFlightService: FlightService {
	var result: Result<PaginationContainer<[FlightResponse]>, ServiceError>!
	var request: FlightRequest!
	
	func retrieve(with request: FlightRequest, completion: @escaping (Result<PaginationContainer<[FlightResponse]>, ServiceError>) -> ()) {
		self.request = request
		completion(result)
	}
}
