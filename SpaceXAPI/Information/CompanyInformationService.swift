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
	
	public func retrieveInformation() {
		// todo: implement
	}
}

public class Service {}
