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
	
	// todo: add mapping
	func test_shouldMapInformation_andReturnInformation_givenServiceReturnsInformation() {
		service.result = .success(.mock(
			name: "Tesla",
			founder: "Also Elon Musk",
			founded: 2021,
			launchSites: 1,
			valuation: 30000000000
		))
		
		let expectation = XCTestExpectation(description: "Result should return")
		var repositoryResult: Result<CompanyInformation, Error>?
		
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
		service.result = .failure(MockError())
		
		let expectation = XCTestExpectation(description: "Result should return")
		var repositoryResult: Result<CompanyInformation, Error>?
		
		repository.retrieve { result in
			repositoryResult = result
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1)
		XCTAssertNotNil(repositoryResult)
		XCTAssertTrue(repositoryResult!.isFailure)
	}
}

// todo: extract
extension CompanyInformation: Equatable {
	public static func == (lhs: CompanyInformation, rhs: CompanyInformation) -> Bool {
		return lhs.companyName == rhs.companyName &&
			lhs.founderName == rhs.founderName &&
			lhs.foundingYear == rhs.foundingYear &&
			lhs.totalLaunchSites == rhs.totalLaunchSites &&
			lhs.unitedStatesDollarValuation == rhs.unitedStatesDollarValuation
	}
}
