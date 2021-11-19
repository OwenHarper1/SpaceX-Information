//
//  DefaultRetrieveFlightUseCaseTests.swift
//  DomainTests
//
//  Created by Owen Harper on 19/11/2021.
//

import XCTest
@testable import Domain

class DefaultRetrieveFlightUseCaseTests: XCTestCase {
	var useCase: DefaultRetrieveFlightUseCase!
	var repository: MockFlightRepository!
	
	override func setUp() {
		repository = .init()
		useCase = .init(repository: repository)
	}
   
	func test_shouldReturnFlights_givenRepositoryReturnsFlights() {
		repository.result = .success([.mock()])
		
		let expectation = XCTestExpectation(description: "Result should return")
		var useCaseResult: Result<[Flight], DomainError>?
		
		useCase.execute { result in
			useCaseResult = result
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1)
		XCTAssertNotNil(useCaseResult)
		XCTAssertTrue(useCaseResult!.isSuccess)
		XCTAssertEqual(try useCaseResult?.get(), [.mock()])
	}
	
	func test_shouldReturnError_givenRepositoryReturnsError() {
		repository.result = .failure(.noInternetConnection)
		
		let expectation = XCTestExpectation(description: "Result should return")
		var useCaseResult: Result<[Flight], DomainError>?
		
		useCase.execute { result in
			useCaseResult = result
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1)
		XCTAssertNotNil(useCaseResult)
		XCTAssertTrue(useCaseResult!.isFailure)
		XCTAssertEqual(useCaseResult, .failure(.noInternetConnection))
	}
}

class MockFlightRepository: FlightRepository {
	var result: Result<[Flight], DomainError>!
	
	func retrieve(completion: @escaping (Result<[Flight], DomainError>) -> ()) {
		completion(result)
	}
}
