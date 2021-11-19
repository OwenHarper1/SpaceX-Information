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
	let rocket: Rocket // todo: need to pull from rocket by ID API
//	let daysToLaunch: Int // todo: make calculated property
	let launchDidSucceed: Bool
	let missionPatchLowResolution: URL?
	let missionPatchHighResolution: URL?
}

// todo: extract
public struct Rocket {
	let name: String
	let type: String
}
