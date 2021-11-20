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
		let request = RequestBuilder()
			.path("company")
			.build()
		
		self.retrieve(request: request, decodingInto: CompanyInformationResponse.self, completion: completion)
	}
}
