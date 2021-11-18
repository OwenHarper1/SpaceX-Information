//
//  CompanyInformationResponse+Extension.swift
//  RepositoryTests
//
//  Created by Owen Harper on 17/11/2021.
//

@testable import Repository
import Foundation

extension CompanyInformationResponse {
	static func mock(address: Address = .mock(),
					 links: Links = .mock(),
					 name: String = "SpaceX",
					 founder: String = "Elon Musk",
					 founded: Int = 2002,
					 employees: Int = 9500,
					 vehicles: Int = 4,
					 launchSites: Int = 3,
					 testSites: Int = 3,
					 ceo: String = "Elon Musk",
					 cto: String = "Elon Musk",
					 coo: String = "Gwynne Shotwell",
					 ctoPropulsion: String = "Tom Mueller",
					 valuation: Int = 74000000000,
					 summary: String = "SpaceX designs, manufactures and launches advanced rockets and spacecraft. The company was founded in 2002 to revolutionize space technology, with the ultimate goal of enabling people to live on other planets.",
					 id: String = "5eb75edc42fea42237d7f3ed") -> Self {
		return .init(name: name,
					 address: address,
					 links: links,
					 founder: founder,
					 founded: founded,
					 employees: employees,
					 vehicles: vehicles,
					 launchSites: launchSites,
					 testSites: testSites,
					 ceo: ceo,
					 cto: cto,
					 coo: coo,
					 ctoPropulsion: ctoPropulsion,
					 valuation: valuation,
					 summary: summary,
					 id: id)
	}
}

extension CompanyInformationResponse.Address {
	static func mock(street: String = "Rocket Road",
					 city: String = "Hawthorne",
					 state: String = "California") -> Self {
		return .init(street: street,
					 city: city,
					 state: state)
	}
}

extension CompanyInformationResponse.Links {
	static func mock(website: URL = .mock(),
					 flickr: URL = .mock(),
					 twitter: URL = .mock(),
					 elonTwitter: URL = .mock()) -> Self {
		return .init(website: website,
					 flickr: flickr,
					 twitter: twitter,
					 elonTwitter: elonTwitter)
	}
}
