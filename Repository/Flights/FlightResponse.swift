//
//  FlightResponse.swift
//  Repository
//
//  Created by Owen Harper on 19/11/2021.
//

import Foundation

public struct FlightResponse: Decodable {
	let fairings: Fairings?
	let links: Links
	let staticFireDateUnix: Date?
	let net: Bool
	let window: Int?
	let rocket: String
	let success: Bool?
	let failures: [Failure]
	let details: String?
	let crew: [String]
	let ships: [String]
	let capsules: [String]
	let payloads: [String]
	let launchpad: String
	let flightNumber: Int
	let name: String
	let dateUnix: Date
	let datePrecision: String
	let upcoming: Bool
	let cores: [Core]?
	let autoUpdate: Bool
	let tbd: Bool
	let launchLibraryID: String?
	let id: String
	
	struct Fairings: Decodable {
		let reused: Bool?
		let recoveryAttempt: Bool?
		let recovered: Bool?
		let ships: [String]
		
		enum CodingKeys: String, CodingKey {
			case reused
			case recoveryAttempt = "recovery_attempt"
			case recovered
			case ships
		}
	}
	
	struct Links: Decodable {
		let patch: Patch
		let reddit: Reddit
		let flickr: Flickr
		let presskit: URL?
		let webcast: URL?
		let youtubeID: String?
		let article: URL?
		let wikipedia: URL?
		
		struct Patch: Codable {
			let small: URL?
			let large: URL?
		}
		
		struct Reddit: Codable {
			let campaign: URL?
			let launch: URL?
			let media: URL?
			let recovery: URL?
		}
		
		struct Flickr: Codable {
			let small: [URL]
			let original: [URL]
		}
		
		enum CodingKeys: String, CodingKey {
			case patch
			case reddit
			case flickr
			case presskit
			case webcast
			case youtubeID = "youtube_id"
			case article
			case wikipedia
		}
	}
	
	struct Failure: Decodable {
		let time: Int
		let altitude: Int?
		let reason: String
	}
	
	struct Core: Decodable {
		let core: String?
		let flight: Int?
		let gridfins: Bool?
		let legs: Bool?
		let reused: Bool?
		let landingAttempt: Bool?
		let landingSuccess: Bool?
		let landingType: String?
		let landpad: String?
		
		enum CodingKeys: String, CodingKey {
			case core
			case flight
			case gridfins
			case legs
			case reused
			case landingAttempt = "landing_attempt"
			case landingSuccess = "landing_success"
			case landingType = "landing_type"
			case landpad
		}
	}
	
	enum CodingKeys: String, CodingKey {
		case fairings
		case links
		case staticFireDateUnix = "static_fire_date_unix"
		case net
		case window
		case rocket
		case success
		case failures
		case details
		case crew
		case ships
		case capsules
		case payloads
		case launchpad
		case flightNumber = "flight_number"
		case name
		case dateUnix = "date_unix"
		case datePrecision = "date_precision"
		case upcoming, cores
		case autoUpdate = "auto_update"
		case tbd
		case launchLibraryID = "launch_library_id"
		case id
	}
}
