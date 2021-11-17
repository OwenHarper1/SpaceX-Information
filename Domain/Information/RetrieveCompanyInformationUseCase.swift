//
//  RetrieveCompanyInformationUseCase.swift
//  Domain
//
//  Created by Owen Harper on 16/11/2021.
//

public protocol RetrieveCompanyInformationUseCase {
	func execute(completion: @escaping (Result<CompanyInformation, Error>) -> ())
}

public class DefaultRetrieveCompanyInformationUseCase: RetrieveCompanyInformationUseCase {
	private let repository: CompanyInformationRepository
	
	public init(repository: CompanyInformationRepository) {
		self.repository = repository
	}
	
	public func execute(completion: @escaping (Result<CompanyInformation, Error>) -> ()) {
		// todo: implement
	}
}
