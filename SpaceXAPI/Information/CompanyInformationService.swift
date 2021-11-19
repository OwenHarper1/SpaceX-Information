//
//  CompanyInformationService.swift
//  SpaceXAPI
//
//  Created by Owen Harper on 16/11/2021.
//

import Repository
import Foundation

public class CompanyInformationService: BaseService, Repository.CompanyInformationService {
	public override init() {}
	
	public func retrieve(completion: @escaping (Result<CompanyInformationResponse, ServiceError>) -> ()) {
		guard let url = URL(string: "\(Self.URLBase)/company") else { // todo: make url generation nicer
			completion(.failure(.invalidURL))
			return
		}
		
		self.retrieve(from: url, httpMethod: .get, decodingInto: CompanyInformationResponse.self, completion: completion)
	}
}
