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
				
				// todo: remove below - old
				
//				let mapped = flightsResponses.docs.map { flightResponse in
//					
//					self.rocketService.retrieve(id: flightResponse.rocket) { rocketResult in
//
//						switch rocketResult {
//						case .success(let rocketResponse):
//
//							let mappedFlight = FlightConverter.convert(flightResponse, rocketResponse)
//							return mappedFlight
//
//						case .failure(let error):
//							break // todo: implement
//						}
//
//					}
//				}
				
				
				break // todo: implement
			case .failure(let error):
				break // todo: fix
			}
		}
	}
}

class FlightConverter {
	static func convert(_ flightResponse: FlightResponse, _ rocketResponse: RocketResponse?) -> Flight {
		return .init(name: flightResponse.name,
					 launchDateTime: flightResponse.dateUTC,
					 rocket: RocketConverter.convert(rocketResponse),
					 launchDidSucceed: flightResponse.success,
					 missionPatchLowResolution: flightResponse.links.patch.small,
					 missionPatchHighResolution: flightResponse.links.patch.large)
	}
}

class RocketConverter {
	static func convert(_ rocketResponse: RocketResponse?) -> Rocket? {
		guard let rocketResponse = rocketResponse else { return nil }
		return .init(name: rocketResponse.name,
					 type: rocketResponse.type)
	}
}
