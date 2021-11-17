//
//  InformationViewController.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 16/11/2021.
//

import UIKit
import Configuration
import Logic
import Domain

class InformationViewController: UIViewController {
	@IBOutlet private weak var collectionView: UICollectionView!
	
	private lazy var viewModel = ViewModelFactory.shared.makeInformationViewModel(with: self)
	private lazy var cellFactory = InformationCollectionViewCellFactory(collectionView: collectionView, viewModel: viewModel)
	private lazy var dataSource = InformationCollectionViewDataSource(cellFactory: cellFactory, viewModel: viewModel)
	private var navigator: InformationNavigator?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		decorateInterface()
		setUpCollectionView()
		
		viewModel.load()
		
		guard let navigationController = navigationController else { return }
		
		navigator = .init(navigationController: navigationController)
    }
	
	// MARK: Set Up -
	
	private func decorateInterface() {
		title = "SpaceX"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let filterButton = UIBarButtonItem(image: .filterIcon, style: .plain, target: self, action: #selector(presentFilterView))
		navigationItem.rightBarButtonItem = filterButton
	}
	
	private func setUpCollectionView() {
		let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
		let layout = UICollectionViewCompositionalLayout.list(using: configuration)
		collectionView.collectionViewLayout = layout
		collectionView.dataSource = dataSource
	}
	
	// MARK: Actions -
	
	@objc private func presentFilterView() {
		navigator?.presentFilter()
	}
}

// todo: extract
class AttributedStringBuilder {
	private var attributedStrings = [NSAttributedString]()
	
	func newLine(count: Int = 1) -> Self {
		let newLines = String(repeating: "\n", count: count)
		return text(newLines)
	}
	
	func fullStop(with properties: [Property] = []) -> Self {
		return text(".", with: properties)
	}
	
	func int(_ int: Int, with properties: [Property] = []) -> Self {
		return text(String(int), with: properties)
	}
	
	func currency(_ amount: Int, symbol: String, with properties: [Property] = []) -> Self {
		let formattedCurrency = amount.withCommas() ?? String(amount)
		return text("\(symbol)\(formattedCurrency)", with: properties)
	}
	
	func optionalText(_ string: String?, with properties: [Property] = []) -> Self {
		guard let string = string else { return self }
		return text(string, with: properties)
	}
	
	func text(_ string: String, with properties: [Property] = []) -> Self {
		let properties = properties.reduce(into: [NSAttributedString.Key: Any]()) {
			$0[$1.key] = $1.attribute
		}
		
		let attributedString = NSAttributedString(string: string, attributes: properties)
		
		attributedStrings.append(attributedString)
		
		return self
	}
	
	func build() -> NSAttributedString {
		let baseString = NSMutableAttributedString()
		
		attributedStrings.forEach { attribute in
			baseString.append(attribute)
		}
		
		return baseString
	}
	
	// MARK: Properties -
	
	enum Property {
		case font(UIFont)
		case colour(UIColor)
		case underlineStyle(NSUnderlineStyle)
		
		var key: NSAttributedString.Key {
			switch self {
			case .font: return .font
			case .colour: return .foregroundColor
			case .underlineStyle: return .underlineStyle
			}
		}
		
		var attribute: Any {
			switch self {
			case .font(let font): return font
			case .colour(let colour): return colour
			case .underlineStyle(let style): return style.rawValue
			}
		}
	}
}

// todo: extract
extension Int {
	func withCommas() -> String? {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .decimal
		return numberFormatter.string(from: NSNumber(value: self))
	}
}

// todo: extract
extension Date {
	func toYear() -> Int? {
		return Calendar.current.dateComponents([.year], from: self).year
	}
}

extension InformationViewController: InformationViewModelDelegate {
	typealias Section = InformationCollectionViewDataSource.Section // todo: maybe move the original declaration into the vc
	
	func retrievedInformation() {
		print("retrieved information")
		DispatchQueue.main.async { // todo: maybe extract this out to an .asyncReload method
			self.collectionView.reloadSections(IndexSet(integer: 0))
		}
	}
	
	func retrieved(_ error: DomainError) {
		// todo: handle
		print("retrieved information error")
		print("error")
	}
}

class InformationCollectionViewDataSource: NSObject, UICollectionViewDataSource {
	private let cellFactory: InformationCollectionViewCellFactory
	private let viewModel: InformationViewModel
	
	init(cellFactory: InformationCollectionViewCellFactory, viewModel: InformationViewModel) {
		self.cellFactory = cellFactory
		self.viewModel = viewModel
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return Section.allCases.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let section = Section(rawValue: section)
		
		switch section {
		case .companyInformation: return viewModel.companyInformation == nil ? 0 : 1
		default: return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		cellFactory.makeCell(at: indexPath)
	}
	
	enum Section: Int, CaseIterable {
		case companyInformation
//		case flights // todo: implement
	}
}

// todo: extract

import UIKit

protocol CellFactory {
	associatedtype CellType
	
	func registerCells()
	func makeCell(at indexPath: IndexPath) -> CellType
}

// todo: extract

import UIKit

class InformationCollectionViewCellFactory: CellFactory {
	typealias Section = InformationCollectionViewDataSource.Section
	
	private let collectionView: UICollectionView
	private let viewModel: InformationViewModel
	
	init(collectionView: UICollectionView, viewModel: InformationViewModel) {
		self.collectionView = collectionView
		self.viewModel = viewModel
		registerCells()
	}
	
	func registerCells() {
		collectionView.register(InformationCompanyCollectionViewCell.self)
	}
	
	func makeCell(at indexPath: IndexPath) -> UICollectionViewCell {
		let section = Section(rawValue: indexPath.section)
		
		switch section {
		case .companyInformation: return makeCompanyCell(at: indexPath)
		default: return UICollectionViewCell()
		}
	}
	
	private func makeCompanyCell(at indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(ofType: InformationCompanyCollectionViewCell.self, at: indexPath), let companyInformation = viewModel.companyInformation else {
			return UICollectionViewCell()
		}
		
		cell.configure(from: companyInformation)
		// todo: add setup
		return cell
	}
}

// todo: extract

import UIKit

extension UICollectionView {
	func register<T: UICollectionViewCell>(_ cellType: T.Type) {
		let name = cellType.identifier
		register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
	}
	
	func dequeueReusableCell<T: UICollectionViewCell>(ofType type: T.Type, at indexPath: IndexPath) -> T? {
		return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
	}
}

// todo: extract

import UIKit

extension NSObject {
	static var identifier: String {
		return String(describing: self)
	}
}

// todo: extract
extension UIColor {
	static let tintColor = UIColor(named: "AccentColor") ?? .systemBlue
}
