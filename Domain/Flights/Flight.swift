//
//  Flight.swift
//  Domain
//
//  Created by Owen Harper on 19/11/2021.
//

import Foundation

public struct Flight {
	public let name: String
	public let launchDateTime: Date
	public let rocket: Rocket?
	public let launchDidSucceed: Bool
	public let missionPatchLowResolution: URL?
	public let missionPatchHighResolution: URL?
	
	public var daysToLaunch: Int {
		let calendar = Calendar.current
		
		let difference = calendar.dateComponents([.day], from: Date(), to: launchDateTime)
		
		return difference.day ?? 0
	}
	
	public init(name: String, launchDateTime: Date, rocket: Rocket?, launchDidSucceed: Bool, missionPatchLowResolution: URL?, missionPatchHighResolution: URL?) {
		self.name = name
		self.launchDateTime = launchDateTime
		self.rocket = rocket
		self.launchDidSucceed = launchDidSucceed
		self.missionPatchLowResolution = missionPatchLowResolution
		self.missionPatchHighResolution = missionPatchHighResolution
	}
}
