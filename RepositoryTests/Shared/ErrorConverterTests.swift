//
//  ErrorConverterTests.swift
//  RepositoryTests
//
//  Created by Owen Harper on 17/11/2021.
//

import XCTest
@testable import Repository

class ErrorConverterTests: XCTestCase {
	
	func test_shouldMapRemoteError() {
		let domainError = ErrorConverter.convert(.remoteError(errorCode: 1, data: nil))
		XCTAssertEqual(domainError, .remoteError)
	}
	
	func test_shouldMapNoInternetConnection() {
		let domainError = ErrorConverter.convert(.unconnected)
		XCTAssertEqual(domainError, .noInternetConnection)
	}
	
	func test_shouldMapUnrecoverableError() {
		let errorCases: [ServiceError] = [
			.invalidURL,
			.decoding(error: MockError()),
			.unknown(error: MockError())
		]
		
		errorCases.forEach { errorCase in
			let domainError = ErrorConverter.convert(errorCase)
			XCTAssertEqual(domainError, .unrecoverableError)
		}
	}
}
