//
//  ViewModelFactory.swift
//  Configuration
//
//  Created by Owen Harper on 16/11/2021.
//

import Logic
import Domain
import Repository
import SpaceXAPI

public class ViewModelFactory {
	// todo: make lazy to reduce memory usage
	public static func makeInformationViewModel() -> InformationViewModel {
		let service = CompanyInformationService()
		let repository = CompanyInformationRepository(service: service)
		let useCase = DefaultRetrieveCompanyInformationUseCase(repository: repository)
		let viewModel = InformationViewModel(useCase: useCase)
		return viewModel
	}
}
