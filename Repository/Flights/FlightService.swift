//
//  FlightService.swift
//  Repository
//
//  Created by Owen Harper on 19/11/2021.
//

public protocol FlightService {
	func retrieve(with request: FlightRequest, completion: @escaping (Result<PaginationContainer<[FlightResponse]>, ServiceError>) -> ())
}
