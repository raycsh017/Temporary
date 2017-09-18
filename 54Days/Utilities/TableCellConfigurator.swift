import UIKit

struct TableCellConfigurator<Cell> where Cell: CellUpdatable, Cell: UITableViewCell {
	let cellData: Cell.CellData
	let reuseIdentifier: String = String(describing: Cell.self)
	let cellClass: AnyClass = Cell.self
	
	func update(cell: AnyObject) {
		if let cell = cell as? Cell {
			cell.update(withCellData: cellData)
		}
	}
}
extension TableCellConfigurator: CellConfiguratorType {}
