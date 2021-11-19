//
//  FlightConverter.swift
//  Repository
//
//  Created by Owen Harper on 19/11/2021.
//

import Domain

class FlightConverter {
	static func convert(_ flightResponse: FlightResponse, _ rockets: [Rocket]) -> Flight {
		let rocket = rockets.first { $0.id == flightResponse.rocket }
		return convert(flightResponse, rocket)
	}
	
	static func convert(_ flightResponse: FlightResponse, _ rocket: Rocket?) -> Flight {
		return .init(name: flightResponse.name,
					 launchDateTime: flightResponse.dateUTC,
					 rocket: rocket,
					 launchDidSucceed: flightResponse.success,
					 missionPatchLowResolution: flightResponse.links.patch.small,
					 missionPatchHighResolution: flightResponse.links.patch.large)
	}
}
