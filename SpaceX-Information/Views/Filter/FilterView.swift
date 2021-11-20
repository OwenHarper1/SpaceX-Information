//
//  FilterView.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 20/11/2021.
//

import SwiftUI
import Logic
import Configuration
import Domain

struct FilterView: View {
	@State private var filterOrder: FilterOrder = .ascending
	@State private var launchSuccessful = false
	@State private var showSpecificYear = false
	@State private var filterFromYear = Date()
	@State private var filterToYear = Date()
	
	private var fromDateRange: PartialRangeThrough<Date> { ...filterToYear }
	private var toDateRange: PartialRangeFrom<Date> { filterFromYear... }
	
	private let dismissHandler: () -> ()
	private var viewModel: InformationViewModel?
	
	init(dismissHandler: @escaping () -> (), viewModel: InformationViewModel?) {
		self.dismissHandler = dismissHandler
		self.viewModel = viewModel
	}
	
	var body: some View {
		NavigationView {
			ZStack {
				VStack {
					Form {
						Section(header: Text("Order")) {
							Picker("Order", selection: $filterOrder) {
								ForEach(FilterOrder.allCases, id: \.self) { order in
									Text(order.displayTitle).tag(order)
								}
							}
						}
						
						Section(header: Text("Successful launches")) {
							Toggle("Only show successful launches", isOn: $launchSuccessful)
						}
						
						Section(header: Text("Filter by Year")) {
							Toggle("Filter by year", isOn: $showSpecificYear)
							
							if showSpecificYear {
								DatePicker("From", selection: $filterFromYear, in: fromDateRange, displayedComponents: .date)
								DatePicker("To", selection: $filterToYear, in: toDateRange, displayedComponents: .date)
							}
						}
						.animation(.linear)
						
					}
					
					Spacer()
					
					Button("Apply") {
						viewModel?.loadFlightInformation(retrievalType: .filtered(filters: generateFilters()))
						dismissHandler()
					}
					.padding(.all, 16)
				}
			}
			.navigationTitle("Filter")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar(content: {
				Button("Close", action: dismissHandler)
			})
		}
	}
	
	private func generateFilters() -> [FlightRetrievalType.FlightFilter] {
		var filters = [FlightRetrievalType.FlightFilter]()
		
		if launchSuccessful {
			filters.append(.onlyShowSuccessfulLaunches)
		}
		
		filters.append(.order(isAscending: filterOrder == .ascending))
		
		if showSpecificYear {
			filters.append(.year(from: filterFromYear, to: filterToYear))
		}
		
		return filters
	}
	
	enum FilterOrder: String, CaseIterable {
		case descending
		case ascending
		
		var displayTitle: String { rawValue.prefix(1).uppercased() + rawValue.lowercased().dropFirst() }
	}
}

struct FilterView_Previews: PreviewProvider {
	static var previews: some View {
		FilterView(dismissHandler: {}, viewModel: nil)
	}
}
