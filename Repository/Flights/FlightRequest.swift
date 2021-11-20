//
//  FlightRequest.swift
//  Repository
//
//  Created by Owen Harper on 20/11/2021.
//

public struct FlightRequest: Encodable {
	let options: Options
	
	struct Options: Encodable {
		let limit: Int
		let page: Int
	}
}
