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
	var error: DomainError!
	
	func retrievedInformation() {
		didRetrieveInformation = true
	}
	
	func retrieved(_ error: DomainError) {
		self.error = error
	}
}
