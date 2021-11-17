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
		service.result = .success(.mock())
		
		let expectation = XCTestExpectation(description: "Result should return")
		var repositoryResult: Result<CompanyInformation, Error>?
		
		repository.retrieve { result in
			repositoryResult = result
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1)
		XCTAssertNotNil(repositoryResult)
		XCTAssertTrue(repositoryResult!.isSuccess)
		// todo: add equatable
	}
	
	/*
	repository.result = .success(.mock())
	
	let expectation = XCTestExpectation(description: "Result should return")
	var useCaseResult: Result<CompanyInformation, Error>?
	
	useCase.execute { result in
		useCaseResult = result
		expectation.fulfill()
	}
	
	wait(for: [expectation], timeout: 1)
	XCTAssertNotNil(useCaseResult)
	XCTAssertTrue(useCaseResult!.isSuccess)
	*/
	
	func test_shouldReturnError_givenServiceReturnsError() {
		
	}
}

// todo: extract
class MockCompanyInformationService: CompanyInformationService {
	var result: Result<CompanyInformationResponse, Error>!
	
	func retrieve(completion: @escaping (Result<CompanyInformationResponse, Error>) -> ()) {
		completion(result)
	}
}

// todo: extract
extension CompanyInformationResponse {
	static func mock(headquarters: Headquarters = .mock(),
					 links: Links = .mock(),
					 name: String = "SpaceX",
					 founder: String = "Elon Musk",
					 founded: Int = 2002,
					 employees: Int = 9500,
					 vehicles: Int = 4,
					 launchSites: Int = 3,
					 testSites: Int = 3,
					 ceo: String = "Elon Musk",
					 cto: String = "Elon Musk",
					 coo: String = "Gwynne Shotwell",
					 ctoPropulsion: String = "Tom Mueller",
					 valuation: Int = 74000000000,
					 summary: String = "SpaceX designs, manufactures and launches advanced rockets and spacecraft. The company was founded in 2002 to revolutionize space technology, with the ultimate goal of enabling people to live on other planets.",
					 id: String = "5eb75edc42fea42237d7f3ed") -> Self {
		return .init(headquarters: headquarters,
					 links: links,
					 name: name,
					 founder: founder,
					 founded: founded,
					 employees: employees,
					 vehicles: vehicles,
					 launchSites: launchSites,
					 testSites: testSites,
					 ceo: ceo,
					 cto: cto,
					 coo: coo,
					 ctoPropulsion: ctoPropulsion,
					 valuation: valuation,
					 summary: summary,
					 id: id)
	}
}

// todo: extract
extension CompanyInformationResponse.Headquarters {
	static func mock(address: String = "Rocket Road",
					 city: String = "Hawthorne",
					 state: String = "California") -> Self {
		return .init(address: address,
					 city: city,
					 state: state)
	}
}

// todo: extract
extension CompanyInformationResponse.Links {
	static func mock(website: URL = .mock(),
					 flickr: URL = .mock(),
					 twitter: URL = .mock(),
					 elonTwitter: URL = .mock()) -> Self {
		return .init(website: website,
					 flickr: flickr,
					 twitter: twitter,
					 elonTwitter: elonTwitter)
	}
}

// todo: extract
extension URL {
	static func mock() -> URL {
		return URL(string: "www.google.com")!
	}
}
