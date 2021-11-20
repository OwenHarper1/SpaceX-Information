//
//  DateFormattingTests.swift
//  SpaceX-InformationTests
//
//  Created by Owen Harper on 20/11/2021.
//

import XCTest
@testable import SpaceX_Information

class DateFormattingTests: XCTestCase {
	func test_shouldFormatDateToYear() {
		let date = Date(timeIntervalSinceReferenceDate: 659103918)
		XCTAssertEqual(date.toYear(), 2021)
	}
	
	func test_shouldFormatDateToYearMonthDay() {
		let date = Date(timeIntervalSinceReferenceDate: 659103918)
		XCTAssertEqual(date.toReadableFormat(.yearMonthDay), "2021/11/20")
	}
	
	func test_shouldformatDateToDayMonthYear() {
		let date = Date(timeIntervalSinceReferenceDate: 659103918)
		XCTAssertEqual(date.toReadableFormat(.dayMonthYear), "20/11/2021")
	}
}
