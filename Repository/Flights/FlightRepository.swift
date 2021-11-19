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
	private let rocketRepository: RocketRepository
	
	init(flightService: FlightService, rocketRepository: RocketRepository) {
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
					guard case .success(let rockets) = rocketResult else {
						// todo: return with all entries as nil rocket
						let mappedFlights = flightsResponse.docs.map { flightResponse -> Flight in
							
							
							return FlightConverter.convert(flightResponse, nil)
							
						}
						completion(.success(mappedFlights))
						return
					}
					
					let mappedFlights = flightsResponse.docs.map { flightResponse -> Flight in
						let rocket = rockets.first { rocketResponse in
								  rocketResponse.id == flightResponse.rocket
							  }
						
						return FlightConverter.convert(flightResponse, rocket)
						
					}
					completion(.success(mappedFlights))
				}
				
				
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}

// todo: extract
class RocketRepository {
	private let service: RocketService
	
	public init(service: RocketService) {
		self.service = service
	}
	
	public func retrieve(for ids: [String], completion: @escaping (Result<[Rocket], DomainError>) -> ()) {
		let dispatchGroup = DispatchGroup()
		
		var rocketResponses = [RocketResponse]()
		
		// todo: tidy
		
		ids.forEach { rocketID in
			dispatchGroup.enter()
			
			self.service.retrieve(id: rocketID) { result in
				guard case .success(let rocketResponse) = result else {
					dispatchGroup.leave()
					return
				}
				
				rocketResponses.append(rocketResponse)
				dispatchGroup.leave()
			}
		}
		
		dispatchGroup.notify(queue: .global(qos: .userInitiated)) {
			guard !rocketResponses.isEmpty else {
				completion(.failure(.remoteError))
				return
			}
			
			let mapped = rocketResponses.compactMap(RocketConverter.convert)
			completion(.success(mapped))
		}
	}
}
