//
//  FilterViewController.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 16/11/2021.
//

import SwiftUI
import Logic

class FilterViewController: UIHostingController<FilterView> {

	init(viewModel: InformationViewModel) {
		super.init(rootView: FilterView())
	}
	
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
//    override func viewDidLoad() {
//        super.viewDidLoad()
//		
//		decorateInterface()
//    }
//	
//	private func decorateInterface() {
//		title = "Filter"
//	}
}
