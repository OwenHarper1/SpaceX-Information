//
//  Result+Extension.swift
//  DomainTests
//
//  Created by Owen Harper on 17/11/2021.
//

extension Result {
	var isSuccess: Bool {
		guard case .success = self else { return false }
		return true
	}
	
	var isFailure: Bool {
		return !isSuccess
	}
}
