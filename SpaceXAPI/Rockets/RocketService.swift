//
//  RocketService.swift
//  SpaceXAPI
//
//  Created by Owen Harper on 19/11/2021.
//

import Foundation
import Repository

public class RocketService: BaseService, Repository.RocketService {
	public override init() {}
	
	public func retrieve(id: String, completion: @escaping (Result<RocketResponse, ServiceError>) -> ()) {
		let request = RequestBuilder()
			.path("rockets")
			.path(id)
			.build()
		
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(formatter)
		
		self.retrieve(request: request, decodingInto: RocketResponse.self, with: decoder, completion: completion)
	}
}
