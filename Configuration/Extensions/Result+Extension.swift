//
//  Result+Extension.swift
//  Configuration
//
//  Created by Owen Harper on 17/11/2021.
//

extension Result {
	func handle(with completion: @escaping ((Result<Success, Failure>) -> Void)) {
		completion(self)
	}
}

extension Result {
	func handle(success: (Success) -> Void, failure: (Failure) -> Void) {
		switch self {
		case .success(let value): success(value)
		case .failure(let error): failure(error)
		}
	}
}
