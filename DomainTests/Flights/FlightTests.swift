//
//  FlightTests.swift
//  DomainTests
//
//  Created by Owen Harper on 20/11/2021.
//

import XCTest
@testable import Domain

class FlightTests: XCTestCase {
	func test_shouldCalculateNegativeDaysToLaunch() {
		let sevenDaysBeforeToday = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
		
		let flight = Flight.mock(launchDateTime: sevenDaysBeforeToday)
		
		XCTAssertEqual(flight.daysToLaunch, -7)
	}
	
	func test_shouldCalculatePositiveDaysToLaunch() {
		let sevenDaysBeforeToday = Calendar.current.date(byAdding: .day, value: 8, to: Date())!
		
		let flight = Flight.mock(launchDateTime: sevenDaysBeforeToday)
		
		XCTAssertEqual(flight.daysToLaunch, 7)
	}
}
