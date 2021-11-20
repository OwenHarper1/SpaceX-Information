//
//  MockRocketService.swift
//  RepositoryTests
//
//  Created by Owen Harper on 19/11/2021.
//

@testable import Repository

class MockRocketService: RocketService {
	var result: Result<RocketResponse, ServiceError>!
	
	func retrieve(id: String, completion: @escaping (Result<RocketResponse, ServiceError>) -> ()) {
		completion(result)
	}
}
