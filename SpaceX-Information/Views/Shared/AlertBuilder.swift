//
//  AlertBuilder.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 18/11/2021.
//

import UIKit

class AlertBuilder {
	private var title: Title?
	private var message: Message?
	private var style: UIAlertController.Style?
	private var actions = [UIAlertAction]()
	private var tint: UIColor?
	
	func title(_ title: Title) -> Self {
		self.title = title
		return self
	}
	
	func message(_ message: Message) -> Self {
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
	
	func action(style: Button, handledBy handler: (() -> Void)? = nil) -> Self {
		let alertAction = UIAlertAction(title: style.rawValue, style: style.style, handler: { _ in handler?() })
		actions.append(alertAction)
		return self
	}
	
	func action(style: Button, handledBy handler: @escaping ((UIAlertAction) -> Void)) -> Self {
		let alertAction = UIAlertAction(title: style.rawValue, style: style.style, handler: handler)
		actions.append(alertAction)
		return self
	}
	
	func build() -> UIAlertController {
		let alertController = UIAlertController(title: title?.rawValue, message: message?.message, preferredStyle: style ?? .alert)
		actions.forEach { alertController.addAction($0) }
		alertController.view.tintColor = tint ?? alertController.view.tintColor
		
		return alertController
	}
	
	enum Title: String {
		case ohNo = "Oh no!"
		case areYouSure = "Are you sure?"
	}
	
	enum Message {
		case custom(String)
		
		var message: String {
			switch self {
			case .custom(let string): return string
			}
		}
	}
	
	enum Button: String {
		case cancel = "Cancel"
		case tryAgain = "Try Again"
		
		var style: UIAlertAction.Style {
			switch self {
			case .cancel: return .cancel
			case .tryAgain: return .default
			}
		}
	}
}
