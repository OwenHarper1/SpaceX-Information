//
//  RetrieveFlightUseCase.swift
//  Domain
//
//  Created by Owen Harper on 19/11/2021.
//

public protocol RetrieveFlightUseCase {
	func execute(completion: @escaping (Result<[Flight], DomainError>) -> ())
}

public class DefaultRetrieveFlightUseCase: RetrieveFlightUseCase {
	private let repository: FlightRepository
	
	public init(repository: FlightRepository) {
		self.repository = repository
	}
	
	public func execute(completion: @escaping (Result<[Flight], DomainError>) -> ()) {
		repository.retrieve(completion: completion)
	}
}
