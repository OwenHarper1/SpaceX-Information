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
		viewModel = InformationViewModel(companyInformationUseCase: useCase, delegate: delegate)
	}
	
	func test_shouldReturnCompanyInformation_givenUseCaseReturnsCompanyInformation() {
		useCase.result = .success(.mock())
		
		viewModel.loadCompanyInformation()
		
		XCTAssertEqual(viewModel.companyInformation, .mock())
		XCTAssertTrue(delegate.didRetrieveInformation)
		XCTAssertNil(delegate.error)
	}
	
	func test_shouldReturnError_givenUseCaseReturnsError() {
		useCase.result = .failure(.noInternetConnection)
		
		viewModel.loadCompanyInformation()
		
		XCTAssertNil(viewModel.companyInformation)
		XCTAssertNil(delegate.didRetrieveInformation)
		XCTAssertEqual(delegate.error, .noInternetConnection)
	}
}
