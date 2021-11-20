//
//  FilterView.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 20/11/2021.
//

import SwiftUI

struct FilterView: View {
	@State private var filterOrder: FilterOrder = .ascending
	@State private var launchSuccessful = false
	@State private var showSpecificYear = false
	@State private var filterFromYear = Date()
	@State private var filterToYear = Date()
	
	private var fromDateRange: PartialRangeThrough<Date> { ...filterToYear }
	private var toDateRange: PartialRangeFrom<Date> { filterFromYear... }
	
	var body: some View {
		NavigationView {
			ZStack {
				VStack {
					Form {
						Picker("Order", selection: $filterOrder) {
							ForEach(FilterOrder.allCases, id: \.self) { order in
								Text(order.displayTitle).tag(order)
							}
						}
						
						Toggle("Only show successful launches", isOn: $launchSuccessful)
						
						Toggle("Filter by year", isOn: $showSpecificYear)
						
						if showSpecificYear {
							DatePicker("From", selection: $filterFromYear, in: fromDateRange, displayedComponents: .date)
							DatePicker("To", selection: $filterToYear, in: toDateRange, displayedComponents: .date)
						}
						
					}
					.navigationTitle("Filter")
					.navigationBarTitleDisplayMode(.inline)
					
					Spacer()
					
					Button("Apply") {
						// todo: implement
						print("filtering...")
					}
					.padding(.all, 16)
				}
			}
		}
	}
	
	enum FilterOrder: String, CaseIterable {
		case ascending
		case descending
		
		var displayTitle: String { rawValue.prefix(1).uppercased() + rawValue.lowercased().dropFirst() }
	}
}

struct FilterView_Previews: PreviewProvider {
	static var previews: some View {
		FilterView()
	}
}
