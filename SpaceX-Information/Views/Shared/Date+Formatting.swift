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
}
