//
//  FlightRepository.swift
//  Domain
//
//  Created by Owen Harper on 18/11/2021.
//

public protocol FlightRepository {
	func retrieve(completion: @escaping (Result<[Flight], DomainError>) -> ())
}
