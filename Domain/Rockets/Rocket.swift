//
//  Rocket.swift
//  Domain
//
//  Created by Owen Harper on 19/11/2021.
//

public struct Rocket {
	public let id: String
	public let name: String
	public let type: String
	
	public init(id: String, name: String, type: String) {
		self.id = id
		self.name = name
		self.type = type
	}
}
