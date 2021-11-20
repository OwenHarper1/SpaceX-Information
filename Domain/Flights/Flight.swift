//
//  Flight.swift
//  Domain
//
//  Created by Owen Harper on 19/11/2021.
//

import Foundation

public struct Flight: Equatable, Hashable {
	public let name: String
	public let launchDateTime: Date
	public let rocket: Rocket?
	public let launchDidSucceed: Bool?
	public let missionPatchLowResolution: URL?
	public let missionPatchHighResolution: URL?
	public let links: Links?
	
	public var daysToLaunch: Int {
		let calendar = Calendar.current
		
		let difference = calendar.dateComponents([.day], from: Date(), to: launchDateTime)
		
		return difference.day ?? 0
	}
	
	public init(name: String, launchDateTime: Date, rocket: Rocket?, launchDidSucceed: Bool?, missionPatchLowResolution: URL?, missionPatchHighResolution: URL?, links: Links?) {
		self.name = name
		self.launchDateTime = launchDateTime
		self.rocket = rocket
		self.launchDidSucceed = launchDidSucceed
		self.missionPatchLowResolution = missionPatchLowResolution
		self.missionPatchHighResolution = missionPatchHighResolution
		self.links = links
	}
	
	public struct Links: Equatable, Hashable {
		public let webcast: URL?
		public let article: URL?
		public let wikipedia: URL?
		
		public var linksPresent: Bool { article != nil || webcast != nil || wikipedia != nil }
		
		public init(webcast: URL?, article: URL?, wikipedia: URL?) {
			self.webcast = webcast
			self.article = article
			self.wikipedia = wikipedia
		}
	}
}
