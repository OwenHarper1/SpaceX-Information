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
	
	override func setUp() {
		flightService = .init()
		rocketService = .init()
		repository = .init(flightService: flightService, rocketService: rocketService)
	}
	
	func test_shouldRetrieveFlightAndRocket_givenBothServicesReturnSuccess() {
		flightService.result = .success(.mock(docs: [
			FlightResponse.mock()
		]))
		rocketService.result = .success(.mock())
	}
	
	func test_shouldReturnError_givenEitherServiceReturnsError() {
		
	}
}
