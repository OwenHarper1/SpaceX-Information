//
//  FilterViewController.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 16/11/2021.
//

import SwiftUI
import Logic

class FilterViewController: UIHostingController<FilterView> {
	init(viewModel: InformationViewModel, dismissHandler: @escaping () -> ()) {
		super.init(rootView: FilterView(dismissHandler: dismissHandler))
	}
	
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
