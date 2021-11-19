//
//  FlightResponse+Extension.swift
//  RepositoryTests
//
//  Created by Owen Harper on 19/11/2021.
//

@testable import Repository
import Foundation

extension FlightResponse {
	static func mock(fairings: Fairings = .mock(),
					 links: Links = .mock(),
					 staticFireDateUTC: Date = Date(timeIntervalSince1970: 1142553600),
					 staticFireDateUnix: Int = 1142553600,
					 net: Bool = false,
					 window: Int = 2,
					 rocket: String = "Rocket1",
					 success: Bool = false,
					 failures: [Failure] = [.mock()],
					 details: String = "Very big rocket",
					 crew: [String] = [],
					 ships: [String] = ["Ship1"],
					 capsules: [String] = ["Capsule1"],
					 payloads: [String] = ["Payload1"],
					 launchpad: String = "JFK Launch Pad 1",
					 flightNumber: Int = 400,
					 name: String = "Falcon 9 Mega Mega Heavy",
					 dateUTC: Date = Date(timeIntervalSince1970: 1143239400),
					 dateUnix: Int = 1143239400,
					 dateLocal: Date = Date(timeIntervalSince1970: 1143239400),
					 datePrecision: String = "hour",
					 upcoming: Bool = false,
					 cores: [Core] = [.mock()],
					 autoUpdate: Bool = true,
					 tbd: Bool = true,
					 launchLibraryID: String? = nil,
					 id: String = "Rocket1ID") -> Self {
		return .init(fairings: fairings,
					 links: links,
					 staticFireDateUTC: staticFireDateUTC,
					 staticFireDateUnix: staticFireDateUnix,
					 net: net,
					 window: window,
					 rocket: rocket,
					 success: success,
					 failures: failures,
					 details: details,
					 crew: crew,
					 ships: ships,
					 capsules: capsules,
					 payloads: payloads,
					 launchpad: launchpad,
					 flightNumber: flightNumber,
					 name: name,
					 dateUTC: dateUTC,
					 dateUnix: dateUnix,
					 dateLocal: dateLocal,
					 datePrecision: datePrecision,
					 upcoming: upcoming,
					 cores: cores,
					 autoUpdate: autoUpdate,
					 tbd: tbd,
					 launchLibraryID: launchLibraryID,
					 id: id)
	}
}

extension FlightResponse.Fairings {
	static func mock(reused: Bool = true,
					 recoveryAttempt: Bool = true,
					 recovered: Bool = false,
					 ships: [String] = []) -> Self {
		return .init(reused: reused,
					 recoveryAttempt: recoveryAttempt,
					 recovered: recovered,
					 ships: ships)
	}
}

extension FlightResponse.Links {
	static func mock(patch: Patch = .mock(),
					 reddit: Reddit = .mock(),
					 flickr: Flickr = .mock(),
					 presskit: URL? = .mock(),
					 webcast: URL? = .mock(),
					 youtubeID: String? = nil,
					 article: URL? = .mock(),
					 wikipedia: URL? = .mock()) -> Self {
		return .init(patch: patch,
					 reddit: reddit,
					 flickr: flickr,
					 presskit: presskit,
					 webcast: webcast,
					 youtubeID: youtubeID,
					 article: article,
					 wikipedia: wikipedia)
	}
}

extension FlightResponse.Links.Patch {
	static func mock(small: URL? = .mock(),
					 large: URL? = .mock()) -> Self {
		return .init(small: small,
					 large: large)
	}
}

extension FlightResponse.Links.Reddit {
	static func mock(campaign: URL? = .mock(),
					 launch: URL? = .mock(),
					 media: URL? = .mock(),
					 recovery: URL? = .mock()) -> Self {
		return .init(campaign: campaign,
					 launch: launch,
					 media: media,
					 recovery: recovery)
	}
}

extension FlightResponse.Links.Flickr {
	static func mock(small: [URL] = [.mock()],
					 original: [URL] = [.mock()]) -> Self {
		return .init(small: small, original: original)
	}
}

extension FlightResponse.Failure {
	static func mock(time: Int = 4,
					 altitude: Int? = 50000,
					 reason: String = "Random combusion") -> Self {
		return .init(time: time,
					 altitude: altitude,
					 reason: reason)
	}
}

extension FlightResponse.Core {
	static func mock(core: String = "Core1",
		flight: Int = 1,
		gridfins: Bool = true,
		legs: Bool = true,
		reused: Bool = false,
		landingAttempt: Bool = true,
		landingSuccess: Bool = false,
		landingType: String? = "ASDS",
		landpad: String? = "Landpad1") -> Self {
		return .init(core: core,
					 flight: flight,
					 gridfins: gridfins,
					 legs: legs,
					 reused: reused,
					 landingAttempt: landingAttempt,
					 landingSuccess: landingSuccess,
					 landingType: landingType,
					 landpad: landpad)
	}
}
