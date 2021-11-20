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

public enum FlightRetrievalType: Equatable {
	case list
	case filtered(filters: [FlightFilter])
	
	public static func == (lhs: FlightRetrievalType, rhs: FlightRetrievalType) -> Bool {
		switch (lhs, rhs) {
		case (.list, .list): return true
		case (.filtered(let leftFilters), .filtered(let rightFilters)): return leftFilters == rightFilters
		default: return false
		}
	}
	
	public enum FlightFilter: Equatable {
		case order(isAscending: Bool)
		case onlyShowSuccessfulLaunches
		case year(from: Date, to: Date)
	}
}
