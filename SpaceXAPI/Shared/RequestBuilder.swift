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
//	private var url: URL?
	private var httpMethod: HTTPMethod?
	
	func path(_ path: String) -> Self {
		paths.append(path)
		return self
	}
	
	func build() -> URLRequest? {
		let path = paths.reduce("") { rolling, next in
			return rolling + "/" + next
		}
		
		guard !path.isEmpty else { return nil }
		
		guard let url = URL(string: "\(Self.URLBase)\(path)") else { return nil }
		
		return URLRequest(url: url)
	}
	
	enum HTTPMethod: String {
		case get
		case post
		
		var method: String { rawValue.capitalized }
	}
}
