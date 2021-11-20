//
//  RequestBuilder.swift
//  SpaceXAPI
//
//  Created by Owen Harper on 20/11/2021.
//

import Foundation

class RequestBuilder {
	static internal let URLBase = "https://api.spacexdata.com/v4"
	
	private var paths = [String]()
	private var httpMethod: HTTPMethod?
	private var body: Encodable?
	private var encoder: JSONEncoder?
	
	func path(_ path: Int) -> Self {
		return self.path(String(path))
	}
	
	func path(_ path: String) -> Self {
		paths.append(path)
		return self
	}
	
	func method(_ method: HTTPMethod) -> Self {
		httpMethod = method
		return self
	}
	
	func body(_ body: Encodable) -> Self {
		self.body = body
		return self
	}
	
	func encoding(with encoder: JSONEncoder) -> Self {
		self.encoder = encoder
		return self
	}
	
	func build() -> URLRequest? {
		let path = paths.reduce("") { rolling, next in
			return rolling + "/" + next
		}
		
		guard !path.isEmpty else { return nil }
		
		guard let url = URL(string: "\(Self.URLBase)\(path)") else { return nil }
		
		var request = URLRequest(url: url)
		request.httpMethod = (httpMethod ?? .get).method
		addJSONData(to: &request)
		
		return request
	}
	
	private func addJSONData(to request: inout URLRequest) {
		guard let body = body?.toJSONData(with: encoder ?? JSONEncoder()) else { return }
		request.httpBody = body
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
	}
	
	enum HTTPMethod: String {
		case get
		case post
		
		var method: String { rawValue.capitalized }
	}
}

fileprivate extension Encodable {
	func toJSONData(with encoder: JSONEncoder) -> Data? {
		try? encoder.encode(self)
	}
}
