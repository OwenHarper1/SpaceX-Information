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
		guard let url = URL(string: "\(Self.URLBase)/rockets/\(id)") else { // todo: make url generation nicer
			completion(.failure(.invalidURL))
			return
		}
		
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(formatter)
		
		self.retrieve(from: url, httpMethod: .get, decodingInto: RocketResponse.self, with: decoder, completion: completion)
	}
}
