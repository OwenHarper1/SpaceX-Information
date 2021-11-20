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
	private lazy var flightService: Repository.FlightService = SpaceXAPI.FlightService()
	private lazy var rocketService: Repository.RocketService = SpaceXAPI.RocketService()
	
	// MARK: Repositories -
	
	private var companyInformationRepository: Domain.CompanyInformationRepository { Repository.CompanyInformationRepository(service: companyInformationService) }
	private var rocketRepository: Domain.RocketRepository { Repository.RocketRepository(service: rocketService) }
	private var flightRepository: Domain.FlightRepository { Repository.FlightRepository(flightService: flightService, rocketRepository: rocketRepository) }
	
	// MARK: Use Cases -
	
	private var retrieveCompanyInformationUseCase: RetrieveCompanyInformationUseCase { DefaultRetrieveCompanyInformationUseCase(repository: companyInformationRepository) }
	private var retrieveFlightUseCase: RetrieveFlightUseCase { DefaultRetrieveFlightUseCase(repository: flightRepository) }
	
	// MARK: View Models -
	
	public func makeInformationViewModel(with delegate: InformationViewModelDelegate) -> InformationViewModel {
		let viewModel = InformationViewModel(companyInformationUseCase: retrieveCompanyInformationUseCase,
											 flightUseCase: retrieveFlightUseCase,
											 delegate: delegate)
		return viewModel
	}
}
