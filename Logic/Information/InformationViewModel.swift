//
//  InformationViewModel.swift
//  Logic
//
//  Created by Owen Harper on 16/11/2021.
//

import Domain

public protocol InformationViewModelDelegate {
	func retrieved(_ information: CompanyInformation)
	func retrieved(_ error: Error)
}

public class InformationViewModel {
	private let useCase: RetrieveCompanyInformationUseCase
	private let delegate: InformationViewModelDelegate
	
	public init(useCase: RetrieveCompanyInformationUseCase, delegate: InformationViewModelDelegate) {
		self.useCase = useCase
		self.delegate = delegate
	}
	
	public func load() {
		useCase.execute {
			$0.handle(success: self.delegate.retrieved,
					  failure: self.delegate.retrieved)
		}
	}
}
