//
//  PaginationContainer.swift
//  Repository
//
//  Created by Owen Harper on 19/11/2021.
//

public struct PaginationContainer<T: Decodable>: Decodable {
	let docs: [T]
	let totalDocs: Int
	let limit: Int
	let totalPages: Int
	let page: Int
	let pagingCounter: Int
	let hasPrevPage: Bool
	let hasNextPage: Bool
	let prevPage: Int?
	let nextPage: Int?
}
