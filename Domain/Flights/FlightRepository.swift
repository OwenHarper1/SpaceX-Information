//
//  FlightRepository.swift
//  Domain
//
//  Created by Owen Harper on 18/11/2021.
//
public protocol FlightRepository {
	func retrieve(completion: @escaping (Result<[Flight], DomainError>) -> ())
}

// todo: extract
import Foundation

public struct Flight {
	let name: String
	let launchDateTime: Date
	let rocket: Rocket? // todo: need to pull from rocket by ID API
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

// todo: extract
public struct Rocket {
	public let id: String
	public let name: String
	public let type: String
	
	public init(id: String, name: String, type: String) {
		self.id = id
		self.name = name
		self.type = type
	}
}
