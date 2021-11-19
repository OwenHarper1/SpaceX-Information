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
	private let companyInformationUseCase: RetrieveCompanyInformationUseCase
	private let delegate: InformationViewModelDelegate
	
	private(set) public var companyInformation: CompanyInformation?
	
	public init(companyInformationUseCase: RetrieveCompanyInformationUseCase, delegate: InformationViewModelDelegate) {
		self.companyInformationUseCase = companyInformationUseCase
		self.delegate = delegate
	}
	
	public func loadCompanyInformation() {
		companyInformationUseCase.execute {
			$0.handle(success: self.handleInformationRetrieved,
					  failure: self.delegate.retrieved)
		}
	}
	
	private func handleInformationRetrieved(_ information: CompanyInformation) {
		delegate.retrievedInformation()
		self.companyInformation = information
	}
	
	public func loadFlightInformation() {
		// todo: implement
	}
}
