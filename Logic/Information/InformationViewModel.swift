//
//  InformationViewModel.swift
//  Logic
//
//  Created by Owen Harper on 16/11/2021.
//

import Domain

public protocol InformationViewModelDelegate {
	func retrievedInformation()
	func retrieved(_ error: DomainError)
}

public class InformationViewModel {
	private let useCase: RetrieveCompanyInformationUseCase
	private let delegate: InformationViewModelDelegate
	
	private(set) public var companyInformation: CompanyInformation?
	
	public init(useCase: RetrieveCompanyInformationUseCase, delegate: InformationViewModelDelegate) {
		self.useCase = useCase
		self.delegate = delegate
	}
	
	public func load() {
		self.useCase.execute {
			$0.handle(success: self.handleInformationRetrieved,
					  failure: self.delegate.retrieved)
		}
	}
	
	private func handleInformationRetrieved(_ information: CompanyInformation) {
		delegate.retrievedInformation()
		self.companyInformation = information
	}
}
