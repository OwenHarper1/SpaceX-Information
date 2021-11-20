//
//  PaginationContainer+Extension.swift
//  RepositoryTests
//
//  Created by Owen Harper on 19/11/2021.
//

@testable import Repository

extension PaginationContainer {
	static func mock<T: Decodable>(docs: T,
								   totalDocs: Int = 0,
								   limit: Int = 0,
								   totalPages: Int = 0,
								   page: Int = 0,
								   pagingCounter: Int = 0,
								   hasPrevPage: Bool = false,
								   hasNextPage: Bool = false,
								   prevPage: Int? = nil,
								   nextPage: Int? = nil) -> PaginationContainer<T> {
		return .init(docs: docs,
					 totalDocs: totalDocs,
					 limit: limit,
					 totalPages: totalPages,
					 page: page,
					 pagingCounter: pagingCounter,
					 hasPrevPage: hasPrevPage,
					 hasNextPage: hasNextPage,
					 prevPage: prevPage,
					 nextPage: nextPage)
	}
}
