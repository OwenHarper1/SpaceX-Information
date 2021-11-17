//
//  InformationViewModelTests.swift
//  LogicTests
//
//  Created by Owen Harper on 17/11/2021.
//

import XCTest
@testable import Logic
@testable import Domain

class InformationViewModelTests: XCTestCase {
	var viewModel: InformationViewModel!
	var useCase: MockRetrieveCompanyInformationUseCase!
	var delegate: MockInformationViewModelDelegate!
	
	override func setUp() {
		useCase = .init()
		delegate = .init()
		viewModel = InformationViewModel(useCase: useCase, delegate: delegate)
	}
	
	func test_shouldReturnCompanyInformation_givenUseCaseReturnsCompanyInformation() {
		useCase.result = .success(.mock())
		
		viewModel.load()
		
		XCTAssertNotNil(delegate.information) // todo: change to equatable
	}
	
	func test_shouldReturnErorr_givenUseCaseReturnsError() {
		
	}
}

// todo: extract
class MockInformationViewModelDelegate: InformationViewModelDelegate {
	var information: CompanyInformation!
	
	func retrieved(_ information: CompanyInformation) {
		self.information = information
	}
}

// todo: extract
class MockRetrieveCompanyInformationUseCase: RetrieveCompanyInformationUseCase {
	var result: Result<CompanyInformation, Error>!
	
	func execute(completion: @escaping (Result<CompanyInformation, Error>) -> ()) {
		completion(result)
	}
}

// todo: extract
extension CompanyInformation {
	static func mock() -> Self {
		return .init()
	}
}
