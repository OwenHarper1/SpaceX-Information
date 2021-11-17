//
//  MockInformationViewModelDelegate.swift
//  LogicTests
//
//  Created by Owen Harper on 17/11/2021.
//

@testable import Logic
@testable import Domain

class MockInformationViewModelDelegate: InformationViewModelDelegate {
	var information: CompanyInformation!
	var error: Error!
	
	func retrieved(_ information: CompanyInformation) {
		self.information = information
	}
	
	func retrieved(_ error: Error) {
		self.error = error
	}
}
