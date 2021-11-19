//
//  Rocket+Extension.swift
//  DomainTests
//
//  Created by Owen Harper on 19/11/2021.
//

@testable import Domain

extension Rocket {
	static func mock(name: String = "Falcon 9 Test Launch",
					 type: String = "Falcon 9") -> Self {
		return .init(name: name,
					 type: type)
	}
}

extension Rocket: Equatable {
	public static func == (lhs: Rocket, rhs: Rocket) -> Bool {
		return lhs.name == rhs.name &&
			lhs.type == rhs.type
	}
}
