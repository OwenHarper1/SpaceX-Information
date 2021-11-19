//
//  RocketConverter.swift
//  Repository
//
//  Created by Owen Harper on 19/11/2021.
//

import Domain

class RocketConverter {
	static func convert(_ rocketResponse: RocketResponse?) -> Rocket? {
		guard let rocketResponse = rocketResponse else { return nil }
		return .init(name: rocketResponse.name,
					 type: rocketResponse.type)
	}
}
