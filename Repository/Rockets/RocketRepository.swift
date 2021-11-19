//
//  RocketRepository.swift
//  Repository
//
//  Created by Owen Harper on 19/11/2021.
//

import Domain
import Foundation

public class RocketRepository: Domain.RocketRepository {
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
