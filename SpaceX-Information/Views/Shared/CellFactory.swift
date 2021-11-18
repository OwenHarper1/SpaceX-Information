//
//  CellFactory.swift
//  SpaceX-Information
//
//  Created by Owen Harper on 17/11/2021.
//

import UIKit

protocol CellFactory {
	associatedtype CellType
	
	func registerCells()
	func makeCell(at indexPath: IndexPath) -> CellType
}
