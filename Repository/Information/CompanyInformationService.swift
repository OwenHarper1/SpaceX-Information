//
//  CompanyInformationService.swift
//  Repository
//
//  Created by Owen Harper on 17/11/2021.
//

public protocol CompanyInformationService {
	func retrieve(completion: @escaping (Result<CompanyInformationResponse, ServiceError>) -> ())
}
