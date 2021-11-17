//
//  CompanyInformationService.swift
//  SpaceXAPI
//
//  Created by Owen Harper on 16/11/2021.
//

import Repository

// todo: make inherit from base service which will have api key etc
public class CompanyInformationService: Service, Repository.CompanyInformationService {
	public override init() {}
	
	public func retrieve(completion: @escaping (Result<CompanyInformationResponse, Error>) -> ()) {
		// todo: implement
	}
}

public class Service {} // todo: see if there's any practical benefit - if not, bin
