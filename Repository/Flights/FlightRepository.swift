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
	private let rocketService: RocketService
	
	init(flightService: FlightService, rocketService: RocketService) {
		self.flightService = flightService
		self.rocketService = rocketService
	}
	
	public func retrieve(completion: @escaping (Result<[Flight], DomainError>) -> ()) {
		flightService.retrieve { result in
			switch result {
			case .success(let flightsResponses):
				let rocketIDs = flightsResponses.docs.map { $0.rocket }
				
				let dispatchGroup = DispatchGroup()
				
				var rocketResponses = [RocketResponse]()
				
				rocketIDs.forEach { rocketID in
					dispatchGroup.enter()
					
					// todo: replace with guard case success
					self.rocketService.retrieve(id: rocketID) { result in
						switch result {
						case .success(let rocketResponse):
							rocketResponses.append(rocketResponse)
							dispatchGroup.leave()
						case .failure(let rocketError):
							dispatchGroup.leave()
							break // todo: implement
						}
					}
				}
				
				dispatchGroup.notify(queue: .global(qos: .userInitiated)) {
					let mappedFlights = flightsResponses.docs.map { flightResponse -> Flight in
						let flight = rocketResponses.first { rocketResponse in
							rocketResponse.id == flightResponse.rocket
						}
						
						return FlightConverter.convert(flightResponse, flight)
					}
					
					completion(.success(mappedFlights))
				}

				break // todo: implement
			case .failure(let error):
				let mappedError = ErrorConverter.convert(error)
				completion(.failure(mappedError))
			}
		}
	}
}
