//
//  FlightRepository.swift
//  Repository
//
//  Created by Owen Harper on 18/11/2021.
//

import Domain

public class FlightRepository: Domain.FlightRepository {
	private let flightService: FlightService
	private let rocketService: RocketService
	
	init(flightService: FlightService, rocketService: RocketService) {
		self.flightService = flightService
		self.rocketService = rocketService
	}
	
	public func retrieve(completion: @escaping (Result<[Flight], DomainError>) -> ()) {
		// todo: implement
	}
}
