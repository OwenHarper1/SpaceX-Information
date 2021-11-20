//
//  FlightRepository.swift
//  Domain
//
//  Created by Owen Harper on 18/11/2021.
//

public protocol FlightRepository {
	func retrieve(retrievalType: FlightRetrievalType, completion: @escaping (Result<[Flight], DomainError>) -> ())
}
