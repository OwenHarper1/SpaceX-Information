//
//  Date+Extension.swift
//  Configuration
//
//  Created by Owen Harper on 17/11/2021.
//

import Foundation

extension Date {
	static func from(years: Int) -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy"
		return dateFormatter.date(from: String(years))
	}
}
