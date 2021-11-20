//
//  FlightRequest.swift
//  Repository
//
//  Created by Owen Harper on 20/11/2021.
//

import Foundation

public struct FlightRequest: Encodable {
	let options: Options
	let query: Query?
	
	struct Options: Encodable {
		let limit: Int
		let page: Int
		let sort: Sort
		
		struct Sort: Encodable {
			let dateSortDirection: SortDirection
			
			enum SortDirection: String, Encodable {
				case ascending = "asc"
				case descending = "desc"
			}
			
			enum CodingKeys: String, CodingKey {
				case dateSortDirection = "date_unix"
			}
		}
		
	}
	
	struct Query: Encodable {
		let date: DateRange?
		let didSucceed: Bool?
		
		struct DateRange: Encodable {
			let fromDate: Date
			let toDate: Date
		}
		
		enum CodingKeys: String, CodingKey {
			case date = "date_unix"
			case didSucceed = "success"
		}
	}
}

// todo: add order (need to look up param)
// needs to be added to options, defualt is ascending
/*
"options":{
	  "limit":1,
	  "sort":{
		 "flight_number":"asc"
	  }
   }
*/


// todo: add only show success launches
/*
"query": {
	  "success": true
  },
*/


// todo: gte = from date
// todo: lte = to date
/*
{
  "query": {
	"date_utc": {
	  "$gte": "2017-06-22T00:00:00.000Z",
	  "$lte": "2017-06-25T00:00:00.000Z"
	}
 }
}
*/
