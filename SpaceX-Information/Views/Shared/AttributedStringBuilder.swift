//
//  AttributedStringBuilder.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 17/11/2021.
//

import UIKit

class AttributedStringBuilder {
	private var attributedStrings = [NSAttributedString]()
	
	func newLine(count: Int = 1) -> Self {
		let newLines = String(repeating: "\n", count: count)
		return text(newLines)
	}
	
	func fullStop(with properties: [Property] = []) -> Self {
		return text(".", with: properties)
	}
	
	func int(_ int: Int, with properties: [Property] = []) -> Self {
		return text(String(int), with: properties)
	}
	
	func currency(_ amount: Int, symbol: String, with properties: [Property] = []) -> Self {
		let formattedCurrency = amount.withCommas() ?? String(amount)
		return text("\(symbol)\(formattedCurrency)", with: properties)
	}
	
	func optionalText(_ string: String?, with properties: [Property] = []) -> Self {
		guard let string = string else { return self }
		return text(string, with: properties)
	}
	
	func text(_ string: String, with properties: [Property] = []) -> Self {
		let properties = properties.reduce(into: [NSAttributedString.Key: Any]()) {
			$0[$1.key] = $1.attribute
		}
		
		let attributedString = NSAttributedString(string: string, attributes: properties)
		
		attributedStrings.append(attributedString)
		
		return self
	}
	
	func build() -> NSAttributedString {
		let baseString = NSMutableAttributedString()
		
		attributedStrings.forEach { baseString.append($0) }
		
		return baseString
	}
	
	// MARK: Properties -
	
	enum Property {
		case font(UIFont)
		case colour(UIColor)
		case underlineStyle(NSUnderlineStyle)
		
		var key: NSAttributedString.Key {
			switch self {
			case .font: return .font
			case .colour: return .foregroundColor
			case .underlineStyle: return .underlineStyle
			}
		}
		
		var attribute: Any {
			switch self {
			case .font(let font): return font
			case .colour(let colour): return colour
			case .underlineStyle(let style): return style.rawValue
			}
		}
	}
}
