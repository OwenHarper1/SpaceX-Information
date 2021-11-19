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
	private lazy var flightService: Repository.FlightService = FooFlightService()
	private lazy var rocketService: Repository.RocketService = FooRocketService()
	
	// MARK: Repositories -
	
	private lazy var companyInformationRepository: Domain.CompanyInformationRepository = Repository.CompanyInformationRepository(service: companyInformationService)
	private lazy var rocketRepository: Domain.RocketRepository = Repository.RocketRepository(service: rocketService)
	private lazy var flightRepository: Domain.FlightRepository = Repository.FlightRepository(flightService: flightService, rocketRepository: rocketRepository)
	
	// MARK: Use Cases -
	
	private lazy var retrieveCompanyInformationUseCase: RetrieveCompanyInformationUseCase = DefaultRetrieveCompanyInformationUseCase(repository: companyInformationRepository)
	private lazy var retrieveFlightUseCase: RetrieveFlightUseCase = DefaultRetrieveFlightUseCase(repository: flightRepository)
	
	// MARK: View Models -
	
	public func makeInformationViewModel(with delegate: InformationViewModelDelegate) -> InformationViewModel {
		let viewModel = InformationViewModel(companyInformationUseCase: retrieveCompanyInformationUseCase,
											 flightUseCase: retrieveFlightUseCase,
											 delegate: delegate)
		return viewModel
	}
}

// todo: delete
class FooFlightService: FlightService {
	func retrieve(completion: @escaping (Result<PaginationContainer<[FlightResponse]>, ServiceError>) -> ()) {
		
	}
	
	
}

// todo: delete
class FooRocketService: RocketService {
	func retrieve(id: String, completion: @escaping (Result<RocketResponse, ServiceError>) -> ()) {
		
	}
	
	
}
