//
//  BaseService.swift
//  SpaceXAPI
//
//  Created by Owen Harper on 18/11/2021.
//

import Foundation
import Repository

public class BaseService {
	static internal let URLBase = "https://api.spacexdata.com/v4"
	static internal let Decoder = JSONDecoder()
	
	func retrieve<T: Decodable>(from url: URL, decodingInto decodable: T.Type, with decoder: JSONDecoder? = nil, completion: @escaping (Result<T, ServiceError>) -> ()) {
		let task = URLSession.shared.dataTask(with: url) { responseData, urlResponse, responseError in
			if let responseData = responseData {
				self.handleDataResponse(responseData, decoder, completion)
			} else if let httpResponse = urlResponse as? HTTPURLResponse {
				self.handleURLResponse(httpResponse, responseData, completion)
			} else if let responseError = responseError {
				self.handleErrorResponse(responseError, completion)
			}
		}
		
		task.resume()
	}
	
	private func handleDataResponse<T: Decodable>(_ responseData: Data, _ decoder: JSONDecoder?, _ completion: @escaping (Result<T, ServiceError>) -> ()) {
		let decoder = decoder ?? Self.Decoder
		
		do {
			let decodedResponse = try decoder.decode(T.self, from: responseData)
			completion(.success(decodedResponse))
		} catch {
			let serviceError: ServiceError = .decoding(error: error)
			self.log(serviceError)
			completion(.failure(serviceError))
		}
	}
	
	private func handleURLResponse<T: Decodable>(_ httpResponse: HTTPURLResponse, _ responseData: Data?, _ completion: @escaping (Result<T, ServiceError>) -> ()) {
		let error = ServiceError.remoteError(errorCode: httpResponse.statusCode, data: responseData)
		self.log(error)
		completion(.failure(error))
	}
	
	private func handleErrorResponse<T: Decodable>(_ responseError: Error, _ completion: @escaping (Result<T, ServiceError>) -> ()) {
		let isConnectionError = (responseError as NSError).code == URLError.notConnectedToInternet.rawValue
		let error: ServiceError = isConnectionError ? .unconnected : .unknown(error: responseError)
		self.log(error)
		completion(.failure(error))
	}
	
	private func log(_ serviceError: ServiceError) {
		#if DEBUG
		print(serviceError)
		// todo: implement
		#endif
	}
}
