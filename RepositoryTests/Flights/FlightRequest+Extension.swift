//
//  FlightRequest+Extension.swift
//  RepositoryTests
//
//  Created by Owen Harper on 20/11/2021.
//

@testable import Repository

extension FlightRequest: Equatable {
	public static func == (lhs: FlightRequest, rhs: FlightRequest) -> Bool {
		return lhs.options == rhs.options &&
			lhs.query == rhs.query
	}
}

extension FlightRequest.Options: Equatable {
	public static func == (lhs: FlightRequest.Options, rhs: FlightRequest.Options) -> Bool {
		return lhs.limit == rhs.limit &&
			lhs.page == rhs.page &&
			lhs.sort == rhs.sort
	}
}

extension FlightRequest.Options.Sort: Equatable {
	public static func == (lhs: FlightRequest.Options.Sort, rhs: FlightRequest.Options.Sort) -> Bool {
		return lhs.dateSortDirection == rhs.dateSortDirection
	}
}

extension FlightRequest.Query: Equatable {
	public static func == (lhs: FlightRequest.Query, rhs: FlightRequest.Query) -> Bool {
		return lhs.date == rhs.date &&
			lhs.didSucceed == rhs.didSucceed
	}
}

extension FlightRequest.Query.DateRange: Equatable {
	public static func == (lhs: FlightRequest.Query.DateRange, rhs: FlightRequest.Query.DateRange) -> Bool {
		return lhs.fromDate == rhs.fromDate &&
			lhs.toDate == rhs.toDate
	}
}
