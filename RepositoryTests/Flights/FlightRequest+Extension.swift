//
//  FlightRequest+Extension.swift
//  RepositoryTests
//
//  Created by Owen Harper on 20/11/2021.
//

@testable import Repository

extension FlightRequest: Equatable {
	public static func == (lhs: FlightRequest, rhs: FlightRequest) -> Bool {
		return lhs.options == rhs.options
	}
}

extension FlightRequest.Options: Equatable {
	public static func == (lhs: FlightRequest.Options, rhs: FlightRequest.Options) -> Bool {
		return lhs.limit == rhs.limit &&
			lhs.page == rhs.page
	}
}
