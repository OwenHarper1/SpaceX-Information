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
		
		XCTAssertEqual(delegate.information, .mock())
		XCTAssertNil(delegate.error)
		XCTAssertFalse(delegate.error is MockError)
	}
	
	func test_shouldReturnError_givenUseCaseReturnsError() {
		useCase.result = .failure(.noInternetConnection)
		
		viewModel.load()
		
		XCTAssertNil(delegate.information)
		XCTAssertNotNil(delegate.error)
		XCTAssertEqual(delegate.error, .noInternetConnection)
	}
}
