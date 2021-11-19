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
	}
	
	func test_shouldReturnError_givenRocketServiceReturnsError() {
		
	}
	
	func test_shouldReturnFlightWithoutRocket_givenFlightServiceReturnsSuccess_andRocketServiceReturnsError() {
		
	}
}

// todo: extract
extension Flight {
	static func mock(name: String = "Falcon 9 Mega Mega Heavy",
					 launchDateTime: Date = Date(timeIntervalSince1970: 1143239400),
					 rocket: Rocket = .mock(),
					 launchDidSucceed: Bool = false,
					 missionPatchLowResolution: URL? = .mock(),
					 missionPatchHighResolution: URL? = .mock()) -> Self {
		return .init(name: name,
					 launchDateTime: launchDateTime,
					 rocket: rocket,
					 launchDidSucceed: launchDidSucceed,
					 missionPatchLowResolution: missionPatchLowResolution,
					 missionPatchHighResolution: missionPatchHighResolution)
	}
}

// todo: extract
extension Flight: Equatable {
	public static func == (lhs: Flight, rhs: Flight) -> Bool {
		return lhs.name == rhs.name &&
			lhs.launchDateTime == rhs.launchDateTime &&
			lhs.rocket == rhs.rocket &&
			lhs.launchDidSucceed == rhs.launchDidSucceed &&
			lhs.missionPatchLowResolution == rhs.missionPatchLowResolution &&
			lhs.missionPatchHighResolution == rhs.missionPatchHighResolution
	}
}

// todo: extract
extension Rocket {
	static func mock(name: String = "Falcon 9 Test Launch",
					 type: String = "Falcon 9") -> Self {
		return .init(name: name,
					 type: type)
	}
}

// todo: extract
extension Rocket: Equatable {
	public static func == (lhs: Rocket, rhs: Rocket) -> Bool {
		return lhs.name == rhs.name &&
			lhs.type == rhs.type
	}
}
