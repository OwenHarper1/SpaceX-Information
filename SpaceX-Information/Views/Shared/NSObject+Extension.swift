//
//  NSObject+Extension.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 17/11/2021.
//

import UIKit

extension NSObject {
	static var identifier: String {
		return String(describing: self)
	}
}
