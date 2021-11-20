//
//  FlightRepository.swift
//  Repository
//
//  Created by Owen Harper on 18/11/2021.
//

import Domain
import Foundation

public class FlightRepository: Domain.FlightRepository {
	static let DefaultPage = 1
	static let DefaultRetrievalType = FlightRetrievalType.list
	
	private let flightService: FlightService
	private let rocketRepository: Domain.RocketRepository
	
	private var currentPage: Int
	private var retrievalType: FlightRetrievalType {
		didSet {
			guard oldValue != retrievalType else { return }
			currentPage = Self.DefaultPage
		}
	}
	
	public init(flightService: FlightService, rocketRepository: Domain.RocketRepository) {
		self.flightService = flightService
		self.rocketRepository = rocketRepository
		currentPage = Self.DefaultPage
		retrievalType = Self.DefaultRetrievalType
	}
	
	public func retrieve(retrievalType: FlightRetrievalType, completion: @escaping (Result<[Flight], DomainError>) -> ()) {
		self.retrievalType = retrievalType
		
		let requestOptions = FlightRequest.Options(limit: 10,
												   page: currentPage,
												   sort: .init(dateSortDirection: retrievalType.isAscending ? .ascending : .descending))
		let request = FlightRequest(options: requestOptions,
									query: retrievalType.query)
		
		flightService.retrieve(with: request) {
			switch $0 {
			case .success(let success):
				self.currentPage += 1
				
				let rocketIDs = success.docs.map { $0.rocket }
				
				self.rocketRepository.retrieve(for: rocketIDs) { rocketResult in
					let rockets = try? rocketResult.get()
					
					let mappedFlights = success.docs.map { FlightConverter.convert($0, rockets ?? []) }
					
					completion(.success(mappedFlights))
				}
				
			case .failure(let error):
				completion(.failure(ErrorConverter.convert(error)))
			}
		}
	}
}

fileprivate extension FlightRetrievalType {
	var isAscending: Bool {
		switch self {
		case .list: return false
		case .filtered(let filters): return filters.reduce(false) { rolling, filter in // todo: this seems borked, check it works
			guard case .order(let isAscending) = filter else { return rolling }
			return isAscending
		}
		}
	}
	
	var query: FlightRequest.Query? {
		switch self {
		case .list: return nil
		case .filtered(let filters):
			guard !filters.isEmpty else { return nil }
			
			var dateRange: FlightRequest.Query.DateRange?
			var onlySuccessfulLaunches: Bool?
			
			filters.forEach { filter in
				switch filter {
				case .order: break
				case .onlyShowSuccessfulLaunches: onlySuccessfulLaunches = true
				case .year(let from, let to): dateRange = .init(fromDate: from, toDate: to)
				}
			}
			
			return .init(date: dateRange, didSucceed: onlySuccessfulLaunches)
		}
	}
}
