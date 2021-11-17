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
			valuation: 30000000000
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

// todo: extract
extension ServiceError: Equatable {
	public static func == (lhs: ServiceError, rhs: ServiceError) -> Bool {
		switch (lhs, rhs) {
		case (.remoteError(let leftErrorCode, let leftData), .remoteError(let rightErrorCode, let rightData)):
			return leftErrorCode == rightErrorCode &&
				leftData == rightData
		case (.unconnected, .unconnected): return true
		case (.invalidURL, .invalidURL): return true
		case (.decoding, .decoding): return true
		case (.unknown, .unknown): return true
		default: return false
		}
	}
}
