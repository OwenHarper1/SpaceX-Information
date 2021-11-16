//
//  RetrieveCompanyInformationUseCase.swift
//  Domain
//
//  Created by Owen Harper on 16/11/2021.
//

// todo: mock in tests
public protocol RetrieveCompanyInformationUseCase {
	func execute() // todo: properly implement
}

// todo: mock in tests
// todo: extract
public protocol CompanyInformationRepository {
	func retrieve() // todo: change method signature
}

public class DefaultRetrieveCompanyInformationUseCase: RetrieveCompanyInformationUseCase {
	private let repository: CompanyInformationRepository
	
	public init(repository: CompanyInformationRepository) {
		self.repository = repository
	}
	
	public func execute() {
		// todo: implement
	}
}
