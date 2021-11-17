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
	public static let shared = ViewModelFactory()
	
	// MARK: Services -
	
	private lazy var companyInformationService: Repository.CompanyInformationService = SpaceXAPI.CompanyInformationService()
	
	// MARK: Repositories -
	
	private lazy var companyInformationRepository: Domain.CompanyInformationRepository = Repository.CompanyInformationRepository(service: companyInformationService)
	
	// MARK: Use Cases -
	
	private lazy var retrieveCompanyInformationUseCase: RetrieveCompanyInformationUseCase = DefaultRetrieveCompanyInformationUseCase(repository: companyInformationRepository)
	
	// MARK: View Models -
	
	public func makeInformationViewModel(with delegate: InformationViewModelDelegate) -> InformationViewModel {
		let viewModel = InformationViewModel(useCase: retrieveCompanyInformationUseCase, delegate: delegate)
		return viewModel
	}
}
