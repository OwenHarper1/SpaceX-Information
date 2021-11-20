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
	var companyInformationUseCase: MockRetrieveCompanyInformationUseCase!
	var flightUseCase: MockRetrieveFlightUseCase!
	var delegate: MockInformationViewModelDelegate!
	
	override func setUp() {
		companyInformationUseCase = .init()
		flightUseCase = .init()
		delegate = .init()
		viewModel = InformationViewModel(companyInformationUseCase: companyInformationUseCase,
										 flightUseCase: flightUseCase,
										 delegate: delegate)
	}
	
	func test_shouldReturnCompanyInformation_givenCompanyInformationUseCaseReturnsCompanyInformation() {
		companyInformationUseCase.result = .success(.mock())
		
		viewModel.loadCompanyInformation()
		
		XCTAssertEqual(viewModel.companyInformation, .mock())
		XCTAssertTrue(delegate.didRetrieveInformation)
		XCTAssertNil(delegate.informationError)
	}
	
	func test_shouldReturnInformationError_givenInformationUseCaseReturnsError() {
		companyInformationUseCase.result = .failure(.noInternetConnection)
		
		viewModel.loadCompanyInformation()
		
		XCTAssertNil(viewModel.companyInformation)
		XCTAssertNil(delegate.didRetrieveInformation)
		XCTAssertEqual(delegate.informationError, .noInternetConnection)
	}
	
	func test_shouldReturnFlights_givenFlightUseCaseReturnsFlights() {
		flightUseCase.result = .success([.mock()])
		
		viewModel.loadFlightInformation()
		
		XCTAssertEqual(viewModel.flights, [.mock()])
		XCTAssertTrue(delegate.didRetrieveFlights)
		XCTAssertNil(delegate.flightError)
	}
	
	func test_shouldReturnFlightError_givenFlightUseCaseReturnsError() {
		flightUseCase.result = .failure(.noInternetConnection)
		
		viewModel.loadFlightInformation()
		
		XCTAssertNil(viewModel.flights)
		XCTAssertNil(delegate.didRetrieveFlights)
		XCTAssertEqual(delegate.flightError, .noInternetConnection)
	}
}
