//
//  RocketRepository.swift
//  Domain
//
//  Created by Owen Harper on 19/11/2021.
//

public protocol RocketRepository {
	func retrieve(for ids: [String], completion: @escaping (Result<[Rocket], DomainError>) -> ())
}
