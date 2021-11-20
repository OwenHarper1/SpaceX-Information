//
//  MockRequestBody.swift
//  SpaceXAPITests
//
//  Created by Owen Harper on 20/11/2021.
//

struct MockRequestBody: Encodable {
	let paramOne: String
	let nextedParam: NestedParam
	
	struct NestedParam: Encodable {
		let paramTwo: String
	}
}
