//
//  Rocket+Extension.swift
//  DomainTests
//
//  Created by Owen Harper on 19/11/2021.
//

@testable import Domain

extension Rocket {
	static func mock(id: String = "Rocket1",
					 name: String = "Falcon 9 Test Launch",
					 type: String = "Falcon 9") -> Self {
		return .init(id: id,
					 name: name,
					 type: type)
	}
}

extension Rocket: Equatable {
	public static func == (lhs: Rocket, rhs: Rocket) -> Bool {
		return lhs.id == rhs.id &&
			lhs.name == rhs.name &&
			lhs.type == rhs.type
	}
}
