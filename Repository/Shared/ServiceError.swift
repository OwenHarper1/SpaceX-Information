//
//  ServiceError.swift
//  Repository
//
//  Created by Owen Harper on 17/11/2021.
//

import Foundation

public enum ServiceError: Error {
	case remoteError(errorCode: Int, data: Data?)
	case unconnected
	case invalidURL
	case decoding(error: Error)
	case unknown(error: Error)
}
