//
//  DefaultRetrieveCompanyInformationUseCaseTests.swift
//  DomainTests
//
//  Created by Owen Harper on 17/11/2021.
//

import XCTest
@testable import Domain

class DefaultRetrieveCompanyInformationUseCaseTests: XCTestCase {
	var useCase: DefaultRetrieveCompanyInformationUseCase!
	var repository: MockCompanyInformationRepository!
	
	override func setUp() {
		repository = .init()
		useCase = .init(repository: repository)
	}
	
	func test_shouldReturnCompanyInformation_givenRepositoryReturnsCompanyInformation() {
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
		// todo: add equatable test
	}
	
	func test_shouldReturnError_givenRepositoryReturnsError() {
		repository.result = .failure(MockError())
		
		let expectation = XCTestExpectation(description: "Result should return")
		var useCaseResult: Result<CompanyInformation, Error>?
		
		useCase.execute { result in
			useCaseResult = result
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1)
		XCTAssertNotNil(useCaseResult)
		XCTAssertTrue(useCaseResult!.isFailure)
		// todo: add equatable test
	}
}

// todo: extract
class MockCompanyInformationRepository: CompanyInformationRepository {
	var result: Result<CompanyInformation, Error>!
	
	func retrieve(completion: @escaping (Result<CompanyInformation, Error>) -> ()) {
		completion(result)
	}
}

// todo: extract
extension Result {
	var isSuccess: Bool {
		guard case .success = self else { return false }
		return true
	}
	
	var isFailure: Bool {
		return !isSuccess
	}
}