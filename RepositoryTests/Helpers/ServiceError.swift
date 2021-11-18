//
//  ServiceError.swift
//  RepositoryTests
//
//  Created by Owen Harper on 18/11/2021.
//

@testable import Repository

extension ServiceError: Equatable {
	public static func == (lhs: ServiceError, rhs: ServiceError) -> Bool {
		switch (lhs, rhs) {
		case (.remoteError(let leftErrorCode, let leftData), .remoteError(let rightErrorCode, let rightData)):
			return leftErrorCode == rightErrorCode &&
				leftData == rightData
		case (.unconnected, .unconnected): return true
		case (.invalidURL, .invalidURL): return true
		case (.decoding, .decoding): return true
		case (.unknown, .unknown): return true
		default: return false
		}
	}
}
