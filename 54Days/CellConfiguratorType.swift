import Foundation
import UIKit

protocol CellConfiguratorType {
	var reuseIdentifier: String { get }
	var cellClass: AnyClass { get }
	
	func update(cell: AnyObject)
}
