import Foundation
import UIKit

protocol CellUpdatable: class {
	associatedtype CellData
	
	func update(withCellData cellData: CellData)
}

