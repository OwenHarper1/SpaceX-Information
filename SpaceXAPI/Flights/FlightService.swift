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
	
	public func retrieve(completion: @escaping (Result<PaginationContainer<[FlightResponse]>, ServiceError>) -> ()) {
		guard let url = URL(string: "\(Self.URLBase)/launches/query") else { // todo: make url generation nicer
			completion(.failure(.invalidURL))
			return
		}
		
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		
		self.retrieve(from: url, httpMethod: .post, decodingInto: PaginationContainer<[FlightResponse]>.self, with: decoder, completion: completion)
	}
}
