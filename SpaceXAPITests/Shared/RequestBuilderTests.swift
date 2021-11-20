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
			.build()
		
		let expectedRequest = URLRequest(url: URL(string: "https://api.spacexdata.com/v4/rockets")!)
		
		XCTAssertEqual(request, expectedRequest)
	}
}
