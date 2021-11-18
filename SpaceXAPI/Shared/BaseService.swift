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
				self.handleDataResponse(url, responseData, decoder, completion)
			} else if let httpResponse = urlResponse as? HTTPURLResponse {
				self.handleURLResponse(url, httpResponse, responseData, completion)
			} else if let responseError = responseError {
				self.handleErrorResponse(url, responseError, completion)
			}
		}
		
		task.resume()
	}
	
	private func handleDataResponse<T: Decodable>(_ url: URL, _ responseData: Data, _ decoder: JSONDecoder?, _ completion: @escaping (Result<T, ServiceError>) -> ()) {
		let decoder = decoder ?? Self.Decoder
		
		do {
			let decodedResponse = try decoder.decode(T.self, from: responseData)
			completion(.success(decodedResponse))
		} catch {
			let serviceError: ServiceError = .decoding(error: error)
			self.log(serviceError, url: url)
			completion(.failure(serviceError))
		}
	}
	
	private func handleURLResponse<T: Decodable>(_ url: URL, _ httpResponse: HTTPURLResponse, _ responseData: Data?, _ completion: @escaping (Result<T, ServiceError>) -> ()) {
		let error = ServiceError.remoteError(errorCode: httpResponse.statusCode, data: responseData)
		self.log(error, url: url)
		completion(.failure(error))
	}
	
	private func handleErrorResponse<T: Decodable>(_ url: URL, _ responseError: Error, _ completion: @escaping (Result<T, ServiceError>) -> ()) {
		let isConnectionError = (responseError as NSError).code == URLError.notConnectedToInternet.rawValue
		let error: ServiceError = isConnectionError ? .unconnected : .unknown(error: responseError)
		self.log(error, url: url)
		completion(.failure(error))
	}
	
	private func log(_ serviceError: ServiceError, url: URL) {
		#if DEBUG
		
		print("--- Retrieved Network Error ---")
		print("Error occurred on \(url.absoluteString)")
		print("Type: \(serviceError.logFriendlyName)")
		print(serviceError.logFriendlyMessage)

		#endif
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
