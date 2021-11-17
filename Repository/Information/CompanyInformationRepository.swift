//
//  CompanyInformationRepository.swift
//  Repository
//
//  Created by Owen Harper on 16/11/2021.
//

import Domain

// todo: extract
public protocol CompanyInformationService {
	func retrieve(completion: @escaping (Result<CompanyInformationResponse, Error>) -> ())
}

public class CompanyInformationRepository: Domain.CompanyInformationRepository {
	private let service: CompanyInformationService
	
	public init(service: CompanyInformationService) {
		self.service = service
	}
	
	public func retrieve(completion: @escaping (Result<CompanyInformation, Error>) -> ()) {
		service.retrieve { result in
			switch result {
			case .success(let information):
				completion(.success(CompanyInformation()))
				break // todo: add mapping
			case .failure(let error):
				break // todo: implement
			}
		}
	}
}

// MARK: TODO - THE BELOW NEEDS TO BE CHECKED AND TIDIED

import Foundation

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
