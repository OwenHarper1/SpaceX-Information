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
	
	func retrieve<T: Decodable>(request: URLRequest?, decodingInto decodable: T.Type, with decoder: JSONDecoder? = nil, completion: @escaping (Result<T, ServiceError>) -> ()) {
		guard let request = request else {
			handleInvalidRequest(completion)
			return
		}
		
		let task = URLSession.shared.dataTask(with: request) { responseData, urlResponse, responseError in
			if let responseData = responseData {
				self.handleDataResponse(request, responseData, decoder, completion)
			} else if let httpResponse = urlResponse as? HTTPURLResponse {
				self.handleURLResponse(request, httpResponse, responseData, completion)
			} else if let responseError = responseError {
				self.handleErrorResponse(request, responseError, completion)
			}
		}
		
		task.resume()
	}
	
	private func handleInvalidRequest<T: Decodable>(_ completion: @escaping (Result<T, ServiceError>) -> ()) {
		let error = ServiceError.invalidURL
		self.log(error, request: nil)
		completion(.failure(error))
	}
	
	private func handleDataResponse<T: Decodable>(_ urlRequest: URLRequest, _ responseData: Data, _ decoder: JSONDecoder?, _ completion: @escaping (Result<T, ServiceError>) -> ()) {
		let decoder = decoder ?? Self.Decoder
		
		do {
			let decodedResponse = try decoder.decode(T.self, from: responseData)
			completion(.success(decodedResponse))
		} catch {
			let serviceError: ServiceError = .decoding(error: error)
			self.log(serviceError, request: urlRequest)
			completion(.failure(serviceError))
		}
	}
	
	private func handleURLResponse<T: Decodable>(_ urlRequest: URLRequest, _ httpResponse: HTTPURLResponse, _ responseData: Data?, _ completion: @escaping (Result<T, ServiceError>) -> ()) {
		let error = ServiceError.remoteError(errorCode: httpResponse.statusCode, data: responseData)
		self.log(error, request: urlRequest)
		completion(.failure(error))
	}
	
	private func handleErrorResponse<T: Decodable>(_ urlRequest: URLRequest, _ responseError: Error, _ completion: @escaping (Result<T, ServiceError>) -> ()) {
		let isConnectionError = (responseError as NSError).code == URLError.notConnectedToInternet.rawValue
		let error: ServiceError = isConnectionError ? .unconnected : .unknown(error: responseError)
		self.log(error, request: urlRequest)
		completion(.failure(error))
	}
	
	private func log(_ serviceError: ServiceError, request: URLRequest?) {
		#if DEBUG
		
		print("--- Retrieved Network Error ---")
		print("Error occured on endpoint: \(request?.url?.absoluteString ?? "Unknown endpoint")")
		print("Request: \(String(describing: request))")
		print("Type: \(serviceError.logFriendlyName)")
		print(serviceError.logFriendlyMessage)

		#endif
	}
	
	enum HTTPMethod {
		case get
		case post
		
		var method: String {
			switch self {
			case .get: return "GET"
			case .post: return "POST"
			}
		}
	}
}

fileprivate extension ServiceError {
	var logFriendlyName: String {
		switch self {
		case .remoteError: return "Remote 🔇"
		case .unconnected: return "Unconnected ❌"
		case .invalidURL: return "Invalid URL 💻"
		case .decoding: return "Parsing 🛠"
		case .unknown: return "Unknown 🚨"
		}
	}
	
	var logFriendlyMessage: String {
		switch self {
		case .remoteError(let errorCode, let data):
			return
				"""
				Remote returned code \(errorCode). Data dump:
				\(data ?? Data())
				"""
		case .unconnected:
			return "System returned unconnected - advise user to check connection"
		case .invalidURL:
			return "Failed to create URL - check URL is constructed correctly"
		case .decoding(let error):
			return
				"""
				Failed to decode remote response. Decoding error:
				\(error)
				"""
		case .unknown(let error):
			return
				"""
				Unknown error occured. Unknown error:
				\(error)
				"""
		}
	}
}
