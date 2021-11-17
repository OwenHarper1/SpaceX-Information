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
