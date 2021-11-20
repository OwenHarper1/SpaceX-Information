//
//  FlightRepositoryTests.swift
//  RepositoryTests
//
//  Created by Owen Harper on 19/11/2021.
//

import XCTest
@testable import Repository
@testable import Domain

class FlightRepositoryTests: XCTestCase {
	var repository: Repository.FlightRepository!
	var flightService: MockFlightService!
	var rocketService: MockRocketService!
	var rocketRepository: Domain.RocketRepository!
	
	override func setUp() {
		flightService = .init()
		rocketService = .init()
		rocketRepository = Repository.RocketRepository(service: rocketService)
		repository = .init(flightService: flightService, rocketRepository: rocketRepository)
	}
	
	func test_shouldRetrieveFlightAndRocket_givenBothServicesReturnSuccess() {
		flightService.result = .success(.mock(docs: [
			FlightResponse.mock()
		]))
		rocketService.result = .success(.mock())
		
		let expectation = expectation(description: "Result should return")
		var repositoryResult: Result<[Flight], DomainError>?
		
		repository.retrieve { result in
			repositoryResult = result
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1)
		XCTAssertNotNil(repositoryResult)
		XCTAssertTrue(repositoryResult!.isSuccess)
		XCTAssertEqual(try repositoryResult?.get(), [.mock()])
		XCTAssertEqual(flightService.request, .init(options: .init(limit: 10, page: 1)))
	}
	
	func test_shouldReturnError_givenRocketServiceReturnsError() {
		flightService.result = .failure(.unknown(error: MockError()))
		
		let expectation = expectation(description: "Result should return")
		var repositoryResult: Result<[Flight], DomainError>?
		
		repository.retrieve { result in
			repositoryResult = result
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1)
		XCTAssertNotNil(repositoryResult)
		XCTAssertTrue(repositoryResult!.isFailure)
	}
	
	func test_shouldReturnFlightWithoutRocket_givenFlightServiceReturnsSuccess_andRocketServiceReturnsError() {
		flightService.result = .success(.mock(docs: [
			FlightResponse.mock()
		]))
		rocketService.result = .failure(.unconnected)
		
		let expectation = expectation(description: "Result should return")
		var repositoryResult: Result<[Flight], DomainError>?
		
		repository.retrieve { result in
			repositoryResult = result
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1)
		XCTAssertNotNil(repositoryResult)
		XCTAssertTrue(repositoryResult!.isSuccess)
		XCTAssertEqual(try repositoryResult?.get(), [.mock(rocket: nil)])
	}
}

// todo: extract
extension FlightRequest: Equatable {
	public static func == (lhs: FlightRequest, rhs: FlightRequest) -> Bool {
		return lhs.options == rhs.options
	}
}

extension FlightRequest.Options: Equatable {
	public static func == (lhs: FlightRequest.Options, rhs: FlightRequest.Options) -> Bool {
		return lhs.limit == rhs.limit &&
			lhs.page == rhs.page
	}
}
