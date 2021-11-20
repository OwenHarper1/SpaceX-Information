//
//  AlertBuilder.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 18/11/2021.
//

import UIKit

class AlertBuilder {
	private var title: Title?
	private var message: String?
	private var style: UIAlertController.Style?
	private var actions = [UIAlertAction]()
	private var tint: UIColor?
	
	func title(_ title: Title) -> Self {
		self.title = title
		return self
	}
	
	func message(_ message: String) -> Self {
		self.message = message
		return self
	}
	
	func tint(_ colour: UIColor) -> Self {
		self.tint = tint
		return self
	}
	
	func style(_ style: UIAlertController.Style) -> Self {
		self.style = style
		return self
	}
	
	func action(if condition: Bool = true, style: Button, handledBy handler: (() -> Void)? = nil) -> Self {
		guard condition else { return self }
		let alertAction = UIAlertAction(title: style.value, style: style.style, handler: { _ in handler?() })
		actions.append(alertAction)
		return self
	}
	
	func build() -> UIAlertController {
		let alertController = UIAlertController(title: title?.rawValue, message: message, preferredStyle: style ?? .alert)
		actions.forEach { alertController.addAction($0) }
		alertController.view.tintColor = tint ?? alertController.view.tintColor
		
		return alertController
	}
	
	enum Title: String {
		case ohNo = "Oh no!"
		case information = "Information"
	}
	
	enum Button {
		case cancel
		case tryAgain
		case custom(String)
		
		var value: String {
			switch self {
			case .cancel: return "Cancel"
			case .tryAgain: return "Try Again"
			case .custom(let value): return value
			}
		}
		
		var style: UIAlertAction.Style {
			switch self {
			case .cancel: return .cancel
			case .tryAgain: return .default
			case .custom: return .default
			}
		}
	}
}

// todo: extract
extension Optional {
	var isNil: Bool {
		return self == nil
	}
}
