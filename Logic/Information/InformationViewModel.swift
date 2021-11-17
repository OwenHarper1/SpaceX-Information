//
//  InformationViewModel.swift
//  Logic
//
//  Created by Owen Harper on 16/11/2021.
//

import Domain

public protocol InformationViewModelDelegate {
	func retrieved(_ information: CompanyInformation)
}

public class InformationViewModel {
	private let useCase: RetrieveCompanyInformationUseCase
	private let delegate: InformationViewModelDelegate
	
	public init(useCase: RetrieveCompanyInformationUseCase, delegate: InformationViewModelDelegate) {
		self.useCase = useCase
		self.delegate = delegate
	}
	
	func load() {
		useCase.execute { result in
			guard case .success(let information) = result else { return }
			self.delegate.retrieved(information)
		}
	}
}
