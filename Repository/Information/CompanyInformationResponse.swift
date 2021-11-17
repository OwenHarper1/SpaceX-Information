//
//  CompanyInformationResponse.swift
//  Repository
//
//  Created by Owen Harper on 17/11/2021.
//

import Foundation

// todo: rename properties

public struct CompanyInformationResponse: Decodable {
	let headquarters: Headquarters
	let links: Links
	let name, founder: String
	let founded: Int
	let employees: Int
	let vehicles: Int
	let launchSites: Int
	let testSites: Int
	let ceo: String
	let cto: String
	let coo: String
	let ctoPropulsion: String
	let valuation: Int
	let summary: String
	let id: String
	
	struct Headquarters: Decodable {
		let address: String
		let city: String
		let state: String
	}
	
	struct Links: Decodable {
		let website: URL
		let flickr: URL
		let twitter: URL
		let elonTwitter: URL
		
		enum CodingKeys: String, CodingKey {
			case website
			case flickr
			case twitter
			case elonTwitter = "elon_twitter"
		}
	}
	
	enum CodingKeys: String, CodingKey {
		case headquarters
		case links
		case name
		case founder
		case founded
		case employees
		case vehicles
		case launchSites = "launch_sites"
		case testSites = "test_sites"
		case ceo
		case cto
		case coo
		case ctoPropulsion = "cto_propulsion"
		case valuation
		case summary
		case id
	}
}
