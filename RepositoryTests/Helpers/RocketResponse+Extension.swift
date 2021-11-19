//
//  RocketResponse+Extension.swift
//  RepositoryTests
//
//  Created by Owen Harper on 19/11/2021.
//

@testable import Repository
import Foundation

extension RocketResponse {
	static func mock(height: Measurement = .mock(),
					 diameter: Measurement = .mock(),
					 mass: Mass = .mock(),
					 firstStage: FirstStage = .mock(),
					 secondStage: SecondStage = .mock(),
					 engines: Engines = .mock(),
					 landingLegs: LandingLegs = .mock(),
					 payloadWeights: [PayloadWeight] = [.mock()],
					 flickrImages: [String] = ["flickrID"],
					 name: String = "Falcon 9 Test Launch",
					 type: String = "Falcon 9",
					 active: Bool = true,
					 stages: Int = 2,
					 boosters: Int = 2,
					 costPerLaunch: Int = 4_000_000,
					 successRatePct: Int = 70,
					 firstFlight: Date = .startOfYear2021(),
					 country: String = "United States",
					 company: String = "Comcast",
					 wikipedia: URL = .mock(),
					 description: String = "SpaceX's first rocket",
					 id: String = "Falcon9ID") -> Self {
		return .init(height: height,
					 diameter: diameter,
					 mass: mass,
					 firstStage: firstStage,
					 secondStage: secondStage,
					 engines: engines,
					 landingLegs: landingLegs,
					 payloadWeights: payloadWeights,
					 flickrImages: flickrImages,
					 name: name,
					 type: type,
					 active: active,
					 stages: stages,
					 boosters: boosters,
					 costPerLaunch: costPerLaunch,
					 successRatePct: successRatePct,
					 firstFlight: firstFlight,
					 country: country,
					 company: company,
					 wikipedia: wikipedia,
					 description: description,
					 id: id)
	}
}

extension RocketResponse.Measurement {
	static func mock(meters: Double = 2,
					 feet: Double = 200) -> Self {
		return .init(meters: meters,
					 feet: feet)
	}
}

extension RocketResponse.Mass {
	static func mock(kg: Int = 60,
					 lb: Int = 400) -> Self {
		return .init(kg: kg,
					 lb: lb)
	}
}

extension RocketResponse.FirstStage {
	static func mock(thrustSeaLevel: RocketResponse.Thrust = .mock(),
					 thrustVacuum: RocketResponse.Thrust = .mock(),
					 reusable: Bool = true,
					 engines: Int = 4,
					 fuelAmountTons: Int = 10000,
					 burnTimeSEC: Int = 20) -> Self {
		return .init(thrustSeaLevel: thrustSeaLevel,
					 thrustVacuum: thrustVacuum,
					 reusable: reusable,
					 engines: engines,
					 fuelAmountTons: fuelAmountTons,
					 burnTimeSEC: burnTimeSEC)
	}
}

extension RocketResponse.SecondStage {
	static func mock(thrust: RocketResponse.Thrust = .mock(),
					 payloads: Payloads = .mock(),
					 reusable: Bool = false,
					 engines: Int = 2,
					 fuelAmountTons: Int = 2000,
					 burnTimeSEC: Int = 40) -> Self {
		return .init(thrust: thrust,
					 payloads: payloads,
					 reusable: reusable,
					 engines: engines,
					 fuelAmountTons: fuelAmountTons,
					 burnTimeSEC: burnTimeSEC)
	}
}

extension RocketResponse.SecondStage.Payloads {
	static func mock(compositeFairing: CompositeFairing = .mock(),
					 option1: String = "Dragon") -> Self {
		return .init(compositeFairing: compositeFairing,
					 option1: option1)
	}
}

extension RocketResponse.SecondStage.Payloads.CompositeFairing {
	static func mock(height: RocketResponse.Measurement = .mock(),
					 diameter: RocketResponse.Measurement = .mock()) -> Self {
		return .init(height: height,
					 diameter: diameter)
	}
}

extension RocketResponse.Thrust {
	static func mock(kN: Int = 600,
					 lbf: Int = 200) -> Self {
		return .init(kN: kN,
					 lbf: lbf)
	}
}

extension RocketResponse.Engines {
	static func mock(isp: ISP = .mock(),
					 thrustSeaLevel: RocketResponse.Thrust = .mock(),
					 thrustVacuum: RocketResponse.Thrust = .mock(),
					 number: Int = 12,
					 type: String = "Raptor",
					 version: String = "1.2.X",
					 layout: String = "Vertical",
					 engineLossMax: Int = 2,
					 propellant1: String = "Oxygen",
					 propellant2: String = "Hydrogen",
					 thrustToWeight: Double = 33) -> Self {
		return .init(isp: isp,
					 thrustSeaLevel: thrustSeaLevel,
					 thrustVacuum: thrustVacuum,
					 number: number,
					 type: type,
					 version: version,
					 layout: layout,
					 engineLossMax: engineLossMax,
					 propellant1: propellant1,
					 propellant2: propellant2,
					 thrustToWeight: thrustToWeight)
	}
}

extension RocketResponse.Engines.ISP {
	static func mock(seaLevel: Int = 200,
					 vacuum: Int = 400) -> Self {
		return .init(seaLevel: seaLevel,
					 vacuum: vacuum)
	}
}

extension RocketResponse.LandingLegs {
	static func mock(number: Int = 4,
					 material: String = "Plywood") -> Self {
		return .init(number: number,
					 material: material)
	}
}

extension RocketResponse.PayloadWeight {
	static func mock(id: String = "PayloadWeight123",
					 name: String = "Low Earth Orbit",
					 kg: Int = 2200,
					 lb: Int = 220000) -> Self {
		return .init(id: id,
					 name: name,
					 kg: kg,
					 lb: lb)
	}
}
