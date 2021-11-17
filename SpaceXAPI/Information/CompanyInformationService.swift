//
//  CompanyInformationService.swift
//  SpaceXAPI
//
//  Created by Owen Harper on 16/11/2021.
//

import Repository

// todo: make inherit from base service which will have api key etc
public class CompanyInformationService: Service, Repository.CompanyInformationService {
	public override init() {}
	
	public func retrieve(completion: @escaping (Result<CompanyInformationResponse, ServiceError>) -> ()) {
		guard let url = URL(string: "https://api.spacexdata.com/v4/company") else { // todo: make url generation nicer
			completion(.failure(.invalidURL))
			return
		}
		
		self.retrieve(from: url, decodingInto: CompanyInformationResponse.self, completion: completion)
	}
}

import Foundation

public class Service {
	static private let URLBase = "https://api.spacexdata.com/v4/"
	static private let Decoder = JSONDecoder()
	
	// todo: consider testing - unsure if needed but might be useful
	func retrieve<T: Decodable>(from url: URL, decodingInto decodable: T.Type, with decoder: JSONDecoder? = nil, completion: @escaping (Result<T, ServiceError>) -> ()) {
		let task = URLSession.shared.dataTask(with: url) { responseData, urlResponse, responseError in
			if let responseData = responseData {
				let decoder = decoder ?? Self.Decoder
				
				do {
					let decodedResponse = try decoder.decode(T.self, from: responseData)
					completion(.success(decodedResponse))
				} catch {
					let serviceError: ServiceError = .decoding(error: error)
					self.log(serviceError)
					completion(.failure(serviceError))
				}
				
				// todo: extract behaviour out
			} else if let httpResponse = urlResponse as? HTTPURLResponse {
				// todo: extract behaviour out
				let error = ServiceError.remoteError(errorCode: httpResponse.statusCode, data: responseData)
				self.log(error)
				completion(.failure(error))
				
			} else if let responseError = responseError {
				
				// todo: extract behaviour out
				let isConnectionError = (responseError as NSError).code == URLError.notConnectedToInternet.rawValue
				let error: ServiceError = isConnectionError ? .unconnected : .unknown(error: responseError)
				self.log(error)
				completion(.failure(error))
				
			}
		}
		
		task.resume()
	}
	
	private func log(_ serviceError: ServiceError) {
		#if DEBUG
		print(serviceError)
		// todo: implement
		#endif
	}
}
