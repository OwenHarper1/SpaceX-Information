//
//  Date+Formatting.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 17/11/2021.
//

import Foundation

extension Date {
	func toYear() -> Int? {
		return Calendar.current.dateComponents([.year], from: self).year
	}
	
	func toReadableFormat(_ format: ReadableFormat) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format.rawValue
		return dateFormatter.string(from: self)
	}
	
	enum ReadableFormat: String {
		case yearMonthDay = "yyyy/MM/dd"
	}
}
