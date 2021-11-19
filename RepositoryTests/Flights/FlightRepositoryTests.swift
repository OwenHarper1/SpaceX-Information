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

// todo: extract
extension RocketResponse {
	static func mock(height: Measurement = .mock(),
					 diameter: Measurement = .mock(),
					 mass: Mass = .mock(),
					 firstStage: FirstStage = .mock(),
					 secondStage: SecondStage = .mock(),
					 engines: Engines = .mock(),
					 landingLegs: LandingLegs = .mock(),
					 payloadWeights: [PayloadWeight] = [.mock()],
					 flickrImages: [String] = ["flickrID"],
					 name: String = "Falcon 9 Test Launch",
					 type: String = "Falcon 9",
					 active: Bool = true,
					 stages: Int = 2,
					 boosters: Int = 2,
					 costPerLaunch: Int = 4_000_000,
					 successRatePct: Int = 70,
					 firstFlight: Date = .startOfYear2021(),
					 country: String = "United States",
					 company: String = "Comcast",
					 wikipedia: URL = .mock(),
					 description: String = "SpaceX's first rocket",
					 id: String = "Falcon9ID") -> Self {
		return .init(height: height,
					 diameter: diameter,
					 mass: mass,
					 firstStage: firstStage,
					 secondStage: secondStage,
					 engines: engines,
					 landingLegs: landingLegs,
					 payloadWeights: payloadWeights,
					 flickrImages: flickrImages,
					 name: name,
					 type: type,
					 active: active,
					 stages: stages,
					 boosters: boosters,
					 costPerLaunch: costPerLaunch,
					 successRatePct: successRatePct,
					 firstFlight: firstFlight,
					 country: country,
					 company: company,
					 wikipedia: wikipedia,
					 description: description,
					 id: id)
	}
}

extension RocketResponse.Measurement {
	static func mock(meters: Double = 2,
					 feet: Double = 200) -> Self {
		return .init(meters: meters,
					 feet: feet)
	}
}

extension RocketResponse.Mass {
	static func mock(kg: Int = 60,
					 lb: Int = 400) -> Self {
		return .init(kg: kg,
					 lb: lb)
	}
}

extension RocketResponse.FirstStage {
	static func mock(thrustSeaLevel: RocketResponse.Thrust = .mock(),
					 thrustVacuum: RocketResponse.Thrust = .mock(),
					 reusable: Bool = true,
					 engines: Int = 4,
					 fuelAmountTons: Int = 10000,
					 burnTimeSEC: Int = 20) -> Self {
		return .init(thrustSeaLevel: thrustSeaLevel,
					 thrustVacuum: thrustVacuum,
					 reusable: reusable,
					 engines: engines,
					 fuelAmountTons: fuelAmountTons,
					 burnTimeSEC: burnTimeSEC)
	}
}

extension RocketResponse.SecondStage {
	static func mock(thrust: RocketResponse.Thrust = .mock(),
					 payloads: Payloads = .mock(),
					 reusable: Bool = false,
					 engines: Int = 2,
					 fuelAmountTons: Int = 2000,
					 burnTimeSEC: Int = 40) -> Self {
		return .init(thrust: thrust,
					 payloads: payloads,
					 reusable: reusable,
					 engines: engines,
					 fuelAmountTons: fuelAmountTons,
					 burnTimeSEC: burnTimeSEC)
	}
}

extension RocketResponse.SecondStage.Payloads {
	static func mock(compositeFairing: CompositeFairing = .mock(),
					 option1: String = "Dragon") -> Self {
		return .init(compositeFairing: compositeFairing,
					 option1: option1)
	}
}

extension RocketResponse.SecondStage.Payloads.CompositeFairing {
	static func mock(height: RocketResponse.Measurement = .mock(),
					 diameter: RocketResponse.Measurement = .mock()) -> Self {
		return .init(height: height,
					 diameter: diameter)
	}
}

extension RocketResponse.Thrust {
	static func mock(kN: Int = 600,
					 lbf: Int = 200) -> Self {
		return .init(kN: kN,
					 lbf: lbf)
	}
}

extension RocketResponse.Engines {
	static func mock(isp: ISP = .mock(),
					 thrustSeaLevel: RocketResponse.Thrust = .mock(),
					 thrustVacuum: RocketResponse.Thrust = .mock(),
					 number: Int = 12,
					 type: String = "Raptor",
					 version: String = "1.2.X",
					 layout: String = "Vertical",
					 engineLossMax: Int = 2,
					 propellant1: String = "Oxygen",
					 propellant2: String = "Hydrogen",
					 thrustToWeight: Double = 33) -> Self {
		return .init(isp: isp,
					 thrustSeaLevel: thrustSeaLevel,
					 thrustVacuum: thrustVacuum,
					 number: number,
					 type: type,
					 version: version,
					 layout: layout,
					 engineLossMax: engineLossMax,
					 propellant1: propellant1,
					 propellant2: propellant2,
					 thrustToWeight: thrustToWeight)
	}
}

extension RocketResponse.Engines.ISP {
	static func mock(seaLevel: Int = 200,
					 vacuum: Int = 400) -> Self {
		return .init(seaLevel: seaLevel,
					 vacuum: vacuum)
	}
}

extension RocketResponse.LandingLegs {
	static func mock(number: Int = 4,
					 material: String = "Plywood") -> Self {
		return .init(number: number,
					 material: material)
	}
}

extension RocketResponse.PayloadWeight {
	static func mock(id: String = "PayloadWeight123",
					 name: String = "Low Earth Orbit",
					 kg: Int = 2200,
					 lb: Int = 220000) -> Self {
		return .init(id: id,
					 name: name,
					 kg: kg,
					 lb: lb)
	}
}

// todo: extract

extension FlightResponse {
	static func mock(fairings: Fairings = .mock(),
					 links: Links = .mock(),
					 staticFireDateUTC: Date = Date(timeIntervalSince1970: 1142553600),
					 staticFireDateUnix: Int = 1142553600,
					 net: Bool = false,
					 window: Int = 2,
					 rocket: String = "Rocket1",
					 success: Bool = false,
					 failures: [Failure] = [.mock()],
					 details: String = "Very big rocket",
					 crew: [String] = [],
					 ships: [String] = ["Ship1"],
					 capsules: [String] = ["Capsule1"],
					 payloads: [String] = ["Payload1"],
					 launchpad: String = "JFK Launch Pad 1",
					 flightNumber: Int = 400,
					 name: String = "Falcon 9 Mega Mega Heavy",
					 dateUTC: Date = Date(timeIntervalSince1970: 1143239400),
					 dateUnix: Int = 1143239400,
					 dateLocal: Date = Date(timeIntervalSince1970: 1143239400),
					 datePrecision: String = "hour",
					 upcoming: Bool = false,
					 cores: [Core] = [.mock()],
					 autoUpdate: Bool = true,
					 tbd: Bool = true,
					 launchLibraryID: String? = nil,
					 id: String = "Rocket1ID") -> Self {
		return .init(fairings: fairings,
					 links: links,
					 staticFireDateUTC: staticFireDateUTC,
					 staticFireDateUnix: staticFireDateUnix,
					 net: net,
					 window: window,
					 rocket: rocket,
					 success: success,
					 failures: failures,
					 details: details,
					 crew: crew,
					 ships: ships,
					 capsules: capsules,
					 payloads: payloads,
					 launchpad: launchpad,
					 flightNumber: flightNumber,
					 name: name,
					 dateUTC: dateUTC,
					 dateUnix: dateUnix,
					 dateLocal: dateLocal,
					 datePrecision: datePrecision,
					 upcoming: upcoming,
					 cores: cores,
					 autoUpdate: autoUpdate,
					 tbd: tbd,
					 launchLibraryID: launchLibraryID,
					 id: id)
	}
}

extension FlightResponse.Fairings {
	static func mock(reused: Bool = true,
					 recoveryAttempt: Bool = true,
					 recovered: Bool = false,
					 ships: [String] = []) -> Self {
		return .init(reused: reused,
					 recoveryAttempt: recoveryAttempt,
					 recovered: recovered,
					 ships: ships)
	}
}

extension FlightResponse.Links {
	static func mock(patch: Patch = .mock(),
					 reddit: Reddit = .mock(),
					 flickr: Flickr = .mock(),
					 presskit: URL? = .mock(),
					 webcast: URL? = .mock(),
					 youtubeID: String? = nil,
					 article: URL? = .mock(),
					 wikipedia: URL? = .mock()) -> Self {
		return .init(patch: patch,
					 reddit: reddit,
					 flickr: flickr,
					 presskit: presskit,
					 webcast: webcast,
					 youtubeID: youtubeID,
					 article: article,
					 wikipedia: wikipedia)
	}
}

extension FlightResponse.Links.Patch {
	static func mock(small: URL? = .mock(),
					 large: URL? = .mock()) -> Self {
		return .init(small: small,
					 large: large)
	}
}

extension FlightResponse.Links.Reddit {
	static func mock(campaign: URL? = .mock(),
					 launch: URL? = .mock(),
					 media: URL? = .mock(),
					 recovery: URL? = .mock()) -> Self {
		return .init(campaign: campaign,
					 launch: launch,
					 media: media,
					 recovery: recovery)
	}
}

extension FlightResponse.Links.Flickr {
	static func mock(small: [URL] = [.mock()],
					 original: [URL] = [.mock()]) -> Self {
		return .init(small: small, original: original)
	}
}

extension FlightResponse.Failure {
	static func mock(time: Int = 4,
					 altitude: Int? = 50000,
					 reason: String = "Random combusion") -> Self {
		return .init(time: time,
					 altitude: altitude,
					 reason: reason)
	}
}

extension FlightResponse.Core {
	static func mock(core: String = "Core1",
		flight: Int = 1,
		gridfins: Bool = true,
		legs: Bool = true,
		reused: Bool = false,
		landingAttempt: Bool = true,
		landingSuccess: Bool = false,
		landingType: String? = "ASDS",
		landpad: String? = "Landpad1") -> Self {
		return .init(core: core,
					 flight: flight,
					 gridfins: gridfins,
					 legs: legs,
					 reused: reused,
					 landingAttempt: landingAttempt,
					 landingSuccess: landingSuccess,
					 landingType: landingType,
					 landpad: landpad)
	}
}

extension PaginationContainer {
	static func mock<T: Decodable>(docs: T,
								   totalDocs: Int = 0,
								   limit: Int = 0,
								   totalPages: Int = 0,
								   page: Int = 0,
								   pagingCounter: Int = 0,
								   hasPrevPage: Bool = false,
								   hasNextPage: Bool = false,
								   prevPage: Int? = nil,
								   nextPage: Int? = nil) -> PaginationContainer<T> {
		return .init(docs: docs,
					 totalDocs: totalDocs,
					 limit: limit,
					 totalPages: totalPages,
					 page: page,
					 pagingCounter: pagingCounter,
					 hasPrevPage: hasPrevPage,
					 hasNextPage: hasNextPage,
					 prevPage: prevPage,
					 nextPage: nextPage)
	}
}

/*
//
//  CompanyInformationRepositoryTests.swift
//  RepositoryTests
//
//  Created by Owen Harper on 17/11/2021.
//

import XCTest
@testable import Repository
@testable import Domain

class CompanyInformationRepositoryTests: XCTestCase {
	var repository: Repository.CompanyInformationRepository!
	var service: MockCompanyInformationService!
	
	override func setUp() {
		service = .init()
		repository = .init(service: service)
	}
	
	func test_shouldMapInformation_andReturnInformation_givenServiceReturnsInformation() {
		service.result = .success(.mock(
			name: "Tesla",
			founder: "Also Elon Musk",
			founded: 2021,
			launchSites: 1,
			valuation: 30000000000,
			summary: "Make rockets go zoom"
		))
		
		let expectation = XCTestExpectation(description: "Result should return")
		var repositoryResult: Result<CompanyInformation, DomainError>?
		
		repository.retrieve { result in
			repositoryResult = result
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1)
		XCTAssertNotNil(repositoryResult)
		XCTAssertTrue(repositoryResult!.isSuccess)
		XCTAssertEqual(try repositoryResult?.get(), .mock())
	}
	
	func test_shouldReturnError_givenServiceReturnsError() {
		service.result = .failure(.decoding(error: MockError()))
		
		let expectation = XCTestExpectation(description: "Result should return")
		var repositoryResult: Result<CompanyInformation, DomainError>?
		
		repository.retrieve { result in
			repositoryResult = result
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1)
		XCTAssertNotNil(repositoryResult)
		XCTAssertTrue(repositoryResult!.isFailure)
	}
}


*/
