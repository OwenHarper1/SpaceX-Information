//
//  Flight+Extension.swift
//  DomainTests
//
//  Created by Owen Harper on 19/11/2021.
//

@testable import Domain
import Foundation

extension Flight {
	static func mock(name: String = "Falcon 9 Mega Mega Heavy",
					 launchDateTime: Date = Date(timeIntervalSince1970: 1143239400),
					 rocket: Rocket? = .mock(),
					 launchDidSucceed: Bool = false,
					 missionPatchLowResolution: URL? = .mock(),
					 missionPatchHighResolution: URL? = .mock(),
					 links: Links? = .mock()) -> Self {
		return .init(name: name,
					 launchDateTime: launchDateTime,
					 rocket: rocket,
					 launchDidSucceed: launchDidSucceed,
					 missionPatchLowResolution: missionPatchLowResolution,
					 missionPatchHighResolution: missionPatchHighResolution,
					 links: links)
	}
}

extension Flight.Links {
	static func mock(webcast: URL? = .mock(),
					 article: URL? = .mock(),
					 wikipedia: URL? = .mock()) -> Self {
		return .init(webcast: webcast,
					 article: article,
					 wikipedia: wikipedia)
	}
}
