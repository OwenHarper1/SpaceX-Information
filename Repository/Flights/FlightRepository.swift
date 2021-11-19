//
//  FlightRepository.swift
//  Repository
//
//  Created by Owen Harper on 18/11/2021.
//

import Domain
import Foundation

public class FlightRepository: Domain.FlightRepository {
	private let flightService: FlightService
	private let rocketRepository: Domain.RocketRepository
	
	init(flightService: FlightService, rocketRepository: Domain.RocketRepository) {
		self.flightService = flightService
		self.rocketRepository = rocketRepository
	}
	
	public func retrieve(completion: @escaping (Result<[Flight], DomainError>) -> ()) {
		flightService.retrieve { result in
			
			let mappedResult = result
				.mapError(ErrorConverter.convert)
			
			switch mappedResult {
			case .success(let flightsResponse):
				let rocketIDs = flightsResponse.docs.map { $0.rocket }
				
				self.rocketRepository.retrieve(for: rocketIDs) { rocketResult in
					let rockets = try? rocketResult.get()

					let mappedFlights = flightsResponse.docs.map { FlightConverter.convert($0, rockets ?? []) }
					
					completion(.success(mappedFlights))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
