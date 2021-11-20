//
//  RequestBuilderTests.swift
//  SpaceXAPITests
//
//  Created by Owen Harper on 20/11/2021.
//

import XCTest
@testable import SpaceXAPI

class RequestBuilderTests: XCTestCase {
	func test_shouldFailRequestBuild_givenURLInvalid() {
		let request = RequestBuilder()
			.build()
		XCTAssertNil(request)
	}
	
	func test_shouldBuildRequest_givenURLValid() {
		let request = RequestBuilder()
			.path("rockets")
			.path(1)
			.build()
		
		let expectedRequest = URLRequest(url: URL(string: "https://api.spacexdata.com/v4/rockets/1")!)
		
		XCTAssertEqual(request, expectedRequest)
	}
	
	func test_shouldAddMethod_givenMethodProvided() {
		let request = RequestBuilder()
			.path("rockets")
			.method(.post)
			.build()
		
		XCTAssertEqual(request?.httpMethod, "POST")
	}
	
	func test_shouldDefaultToGET_givenNoMethodProvided() {
		let request = RequestBuilder()
			.path("rockets")
			.build()
		
		XCTAssertEqual(request?.httpMethod, "GET")
	}
}
