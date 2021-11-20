//
//  MockInformationViewModelDelegate.swift
//  LogicTests
//
//  Created by Owen Harper on 17/11/2021.
//

@testable import Logic
@testable import Domain

class MockInformationViewModelDelegate: InformationViewModelDelegate {
	var didRetrieveInformation: Bool!
	var informationError: DomainError!
	var didRetrieveFlights: Bool!
	var flightError: DomainError!
	
	func retrievedInformation() {
		didRetrieveInformation = true
	}
	
	func retrieved(informationError error: DomainError) {
		self.informationError = error
	}
	
	func retrievedFlights() {
		didRetrieveFlights = true
	}
	
	func retrieved(flightError error: DomainError) {
		self.flightError = error
	}
}
