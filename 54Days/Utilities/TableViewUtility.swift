import UIKit

protocol TableViewUtilityDelegate: class {
	func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath)
}

extension TableViewUtilityDelegate {
	func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) {}
}

class TableViewUtility: NSObject {
	let tableView: UITableView
	
	weak var delegate: TableViewUtilityDelegate?
	
	var cellConfiguratorSections: [CellConfiguratorSection] = []
	
	init(tableView: UITableView) {
		self.tableView = tableView
		super.init()
		
		self.tableView.dataSource = self
		self.tableView.delegate = self
	}
	
	func register(sections cellConfiguratorSections: [CellConfiguratorSection]) {
		self.cellConfiguratorSections = cellConfiguratorSections
		register()
	}
	
	func register(cells cellConfigurators: [CellConfiguratorType]) {
		let cellConfiguratorSection = CellConfiguratorSection(cellConfigurators: cellConfigurators)
		cellConfiguratorSections = [cellConfiguratorSection]
		register()
	}
	
	private func register() {
		for section in cellConfiguratorSections {
			for cellConfigurator in section.cellConfigurators {
				tableView.register(cellConfigurator.cellClass, forCellReuseIdentifier: cellConfigurator.reuseIdentifier)
			}
		}
	}
	
	func reload() {
		tableView.reloadData()
	}
}

extension TableViewUtility: UITableViewDataSource {
	func numberOfSections(in TableView: UITableView) -> Int {
		return cellConfiguratorSections.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellConfiguratorSections[section].cellConfigurators.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let section = cellConfiguratorSections[indexPath.section]
		let cellConfigurator = section.cellConfigurators[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: cellConfigurator.reuseIdentifier, for: indexPath)
		cellConfigurator.update(cell: cell)
		
		delegate?.tableViewUtility(self, reusableCell: cell, cellForRowAt: indexPath)
		
		return cell
	}
}

extension TableViewUtility: UITableViewDelegate {
	
}
