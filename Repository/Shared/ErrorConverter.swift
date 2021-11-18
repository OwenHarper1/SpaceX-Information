//
//  ErrorConverter.swift
//  Repository
//
//  Created by Owen Harper on 17/11/2021.
//

import Domain

class ErrorConverter {
	static func convert(_ error: ServiceError) -> DomainError {
		switch error {
		case .remoteError: return .remoteError
		case .unconnected: return .noInternetConnection
		case .invalidURL, .decoding, .unknown: return .unrecoverableError
		}
	}
}
