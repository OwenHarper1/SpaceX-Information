//
//  FlightService.swift
//  SpaceXAPI
//
//  Created by Owen Harper on 19/11/2021.
//

import Foundation
import Repository

public class FlightService: BaseService, Repository.FlightService {
	public override init() {}
	
	public func retrieve(with request: FlightRequest, completion: @escaping (Result<PaginationContainer<[FlightResponse]>, ServiceError>) -> ()) {
		let request = RequestBuilder()
			.method(.post)
			.path("launches")
			.path("query")
			.body(request)
			.build()
		
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		
		self.retrieve(request: request, decodingInto: PaginationContainer<[FlightResponse]>.self, with: decoder, completion: completion)
	}
}
