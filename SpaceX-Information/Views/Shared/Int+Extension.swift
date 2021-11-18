//
//  Int+Extension.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 17/11/2021.
//

import Foundation

extension Int {
	func withCommas() -> String? {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .decimal
		return numberFormatter.string(from: NSNumber(value: self))
	}
}
