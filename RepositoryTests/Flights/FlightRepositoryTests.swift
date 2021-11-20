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
		flightService.result = .success(.mock(docs: [FlightResponse.mock()]))
		rocketService.result = .success(.mock())
		
		let expectation = expectation(description: "Result should return")
		var repositoryResult: Result<[Flight], DomainError>?
		
		repository.retrieve(retrievalType: .list) { result in
			repositoryResult = result
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1)
		XCTAssertNotNil(repositoryResult)
		XCTAssertTrue(repositoryResult!.isSuccess)
		XCTAssertEqual(try repositoryResult?.get(), [.mock()])
		XCTAssertEqual(flightService.request, .init(options: .init(limit: 10, page: 1, sort: .init(dateSortDirection: .descending)), query: nil))
	}
	
	func test_shouldRetrieveFilteredFlightAndRocket_givenBothServicesReturnSuccess() {
		flightService.result = .success(.mock(docs: [FlightResponse.mock()]))
		rocketService.result = .success(.mock())
		
		let expectation = expectation(description: "Result should return")
		var repositoryResult: Result<[Flight], DomainError>?
		
		let fromDate = Date.distantPast
		let toDate = Date.distantFuture
		
		let filters: [FlightRetrievalType.FlightFilter] = [
			.order(isAscending: true),
			.onlyShowSuccessfulLaunches,
			.year(from: fromDate, to: toDate)
		]
		
		repository.retrieve(retrievalType: .filtered(filters: filters)) { result in
			repositoryResult = result
			expectation.fulfill()
		}
		
		let expectedQuery: FlightRequest.Query = .init(date: FlightRequest.Query.DateRange(fromDate: fromDate, toDate: toDate), didSucceed: true)
		
		wait(for: [expectation], timeout: 1)
		XCTAssertNotNil(repositoryResult)
		XCTAssertTrue(repositoryResult!.isSuccess)
		XCTAssertEqual(try repositoryResult?.get(), [.mock()])
		XCTAssertEqual(flightService.request, .init(options: .init(limit: 10, page: 1, sort: .init(dateSortDirection: .ascending)), query: expectedQuery))
	}
	
	func test_shouldIncrementPageNumber_givenServiceReturnsSuccess() {
		[FlightRetrievalType.list, .filtered(filters: [])].forEach { retrievalType in
			(1...10).forEach { page in
				flightService.result = .success(.mock(docs: [FlightResponse.mock()]))
				rocketService.result = .success(.mock())
				
				let expectation = expectation(description: "Result should return")
				repository.retrieve(retrievalType: retrievalType) { _ in expectation.fulfill() }
				
				wait(for: [expectation], timeout: 1)
				XCTAssertEqual(flightService.request, .init(options: .init(limit: 10, page: page, sort: .init(dateSortDirection: .descending)), query: nil))
			}
		}
	}
	
	func test_shouldReturnError_givenRocketServiceReturnsError() {
		[FlightRetrievalType.list, .filtered(filters: [])].forEach { retrievalType in
			flightService.result = .failure(.unknown(error: MockError()))
			
			let expectation = expectation(description: "Result should return")
			var repositoryResult: Result<[Flight], DomainError>?
			
			repository.retrieve(retrievalType: retrievalType) { result in
				repositoryResult = result
				expectation.fulfill()
			}
			
			wait(for: [expectation], timeout: 1)
			XCTAssertNotNil(repositoryResult)
			XCTAssertTrue(repositoryResult!.isFailure)
		}
	}
	
	func test_shouldNotIncrementPageNumber_givenServiceReturnsError() {
		[FlightRetrievalType.list, .filtered(filters: [])].forEach { retrievalType in
			(1...10).forEach { page in
				flightService.result = .failure(.invalidURL)
				
				let expectation = expectation(description: "Result should return")
				repository.retrieve(retrievalType: retrievalType) { _ in expectation.fulfill() }
				
				wait(for: [expectation], timeout: 1)
				XCTAssertEqual(flightService.request, .init(options: .init(limit: 10, page: 1, sort: .init(dateSortDirection: .descending)), query: nil))
			}
		}
	}
	
	func test_shouldReturnFlightWithoutRocket_givenFlightServiceReturnsSuccess_andRocketServiceReturnsError() {
		flightService.result = .success(.mock(docs: [FlightResponse.mock()]))
		rocketService.result = .failure(.unconnected)
		
		let expectation = expectation(description: "Result should return")
		var repositoryResult: Result<[Flight], DomainError>?
		
		repository.retrieve(retrievalType: .list) { result in
			repositoryResult = result
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1)
		XCTAssertNotNil(repositoryResult)
		XCTAssertTrue(repositoryResult!.isSuccess)
		XCTAssertEqual(try repositoryResult?.get(), [.mock(rocket: nil)])
	}
}
