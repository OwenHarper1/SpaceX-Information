//
//  Flight.swift
//  Domain
//
//  Created by Owen Harper on 19/11/2021.
//

import Foundation

public struct Flight {
	let name: String
	let launchDateTime: Date
	let rocket: Rocket?
//	let daysToLaunch: Int // todo: make calculated property
	let launchDidSucceed: Bool
	let missionPatchLowResolution: URL?
	let missionPatchHighResolution: URL?
	
	public init(name: String, launchDateTime: Date, rocket: Rocket?, launchDidSucceed: Bool, missionPatchLowResolution: URL?, missionPatchHighResolution: URL?) {
		self.name = name
		self.launchDateTime = launchDateTime
		self.rocket = rocket
		self.launchDidSucceed = launchDidSucceed
		self.missionPatchLowResolution = missionPatchLowResolution
		self.missionPatchHighResolution = missionPatchHighResolution
	}
}
