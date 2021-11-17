//
//  CompanyInformationRepository.swift
//  Domain
//
//  Created by Owen Harper on 17/11/2021.
//

public protocol CompanyInformationRepository {
	func retrieve(completion: @escaping (Result<CompanyInformation, Error>) -> ())
}
