//
//  RocketService.swift
//  Repository
//
//  Created by Owen Harper on 19/11/2021.
//

public protocol RocketService {
	func retrieve(id: String, completion: @escaping (Result<RocketResponse, ServiceError>) -> ())
}
