//
//  InformationViewModel.swift
//  Logic
//
//  Created by Owen Harper on 16/11/2021.
//

import Domain

public protocol InformationViewModelDelegate {
	func retrievedInformation()
	func retrieved(informationError error: DomainError)
	func retrievedFlights()
	func retrieved(flightError error: DomainError)
}

public class InformationViewModel {
	private let companyInformationUseCase: RetrieveCompanyInformationUseCase
	private let flightUseCase: RetrieveFlightUseCase
	private let delegate: InformationViewModelDelegate
	
	private(set) public var companyInformation: CompanyInformation?
	private(set) public var flights: [Flight]?
	
	public init(companyInformationUseCase: RetrieveCompanyInformationUseCase, flightUseCase: RetrieveFlightUseCase, delegate: InformationViewModelDelegate) {
		self.companyInformationUseCase = companyInformationUseCase
		self.flightUseCase = flightUseCase
		self.delegate = delegate
	}
	
	public func loadCompanyInformation() {
		companyInformationUseCase.execute {
			$0.handle(success: self.handleInformationRetrieved,
					  failure: self.delegate.retrieved(informationError:))
		}
	}
	
	private func handleInformationRetrieved(_ information: CompanyInformation) {
		companyInformation = information
		delegate.retrievedInformation()
	}
	
	public func loadFlightInformation() {
		flightUseCase.execute {
			$0.handle(success: self.handleFlightsRetrieved,
					  failure: self.delegate.retrieved(flightError:))
		}
	}
	
	private func handleFlightsRetrieved(_ flights: [Flight]) {
		self.flights = self.flights ?? []
		self.flights?.append(contentsOf: flights)
		delegate.retrievedFlights()
	}
}
