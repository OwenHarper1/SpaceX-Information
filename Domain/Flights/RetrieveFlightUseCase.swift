//
//  RetrieveFlightUseCase.swift
//  Domain
//
//  Created by Owen Harper on 19/11/2021.
//

import Foundation

public protocol RetrieveFlightUseCase {
	func execute(retrievalType: FlightRetrievalType, completion: @escaping (Result<[Flight], DomainError>) -> ())
}

public class DefaultRetrieveFlightUseCase: RetrieveFlightUseCase {
	private let repository: FlightRepository
	
	public init(repository: FlightRepository) {
		self.repository = repository
	}
	
	public func execute(retrievalType: FlightRetrievalType, completion: @escaping (Result<[Flight], DomainError>) -> ()) {
		repository.retrieve(retrievalType: retrievalType, completion: completion)
	}
}

public enum FlightRetrievalType {
	case list
	case filtered
	
	enum FlightFilter {
		case order(isAscending: Bool)
		case onlyShowSuccessfulLaunches
		case year(to: Date, from: Date)
	}
}
