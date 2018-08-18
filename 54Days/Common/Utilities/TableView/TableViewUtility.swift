import UIKit

protocol TableViewUtilityDelegate: class {
	func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath)
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
}

extension TableViewUtilityDelegate {
	func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) {}
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {}
}

class TableViewUtility: NSObject {
	let tableView: TableView
	var headerView: UIView?
	var footerView: UIView?
	
	weak var delegate: TableViewUtilityDelegate?
	
	var cellSectionConfigurators: [CellSectionConfigurator] = []
	
	init(tableView: TableView) {
		self.tableView = tableView
		super.init()
		
		self.tableView.dataSource = self
		self.tableView.delegate = self
	}
	
	func register(sections cellSectionConfigurators: [CellSectionConfigurator]) {
		self.cellSectionConfigurators = cellSectionConfigurators
		register()
	}
	
	func register(cells cellConfigurators: [CellConfiguratorType], sectionHeaderView: UIView? = nil, sectionFooterView: UIView? = nil) {
		let sectionConfigurator = CellSectionConfigurator(cellConfigurators: cellConfigurators, sectionHeaderView: sectionHeaderView, sectionFooterView: sectionFooterView)
		cellSectionConfigurators = [sectionConfigurator]
		register()
	}
	
	private func register() {
		for section in cellSectionConfigurators {
			for cellConfigurator in section.cellConfigurators {
				tableView.register(cellConfigurator.cellClass, forCellReuseIdentifier: cellConfigurator.reuseIdentifier)
			}
		}
	}
	
	func reloadData() {
		tableView.reloadData()
	}
	
	func setHeaderView(_ view: UIView) {
		view.resizeForTableHeaderAndFooter()
		tableView.tableHeaderView = view
		tableView.layoutIfNeeded()
	}
	
	func setFooterView(_ view: UIView) {
		view.resizeForTableHeaderAndFooter()
		tableView.tableFooterView = view
		tableView.layoutIfNeeded()
	}
}

extension TableViewUtility: UITableViewDataSource {
	func numberOfSections(in TableView: UITableView) -> Int {
		return cellSectionConfigurators.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellSectionConfigurators[section].cellConfigurators.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let section = cellSectionConfigurators[indexPath.section]
		let cellConfigurator = section.cellConfigurators[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: cellConfigurator.reuseIdentifier, for: indexPath)
		cellConfigurator.update(cell: cell)
		
		delegate?.tableViewUtility(self, reusableCell: cell, cellForRowAt: indexPath)
		
		return cell
	}

}

extension TableViewUtility: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let sectionConfigurator = cellSectionConfigurators[section]
		let sectionHeaderView = sectionConfigurator.sectionHeaderView
		sectionHeaderView?.resizeForTableHeaderAndFooter()
		return sectionHeaderView
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		let sectionConfigurator = cellSectionConfigurators[section]
		return sectionConfigurator.sectionHeaderView == nil ? 0 : UITableViewAutomaticDimension
	}

	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let sectionConfigurator = cellSectionConfigurators[section]
		let sectionFooterView = sectionConfigurator.sectionFooterView
		sectionFooterView?.resizeForTableHeaderAndFooter()
		return sectionFooterView
	}

	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		let sectionConfigurator = cellSectionConfigurators[section]
		return sectionConfigurator.sectionFooterView == nil ? 0 : UITableViewAutomaticDimension
	}
}

extension TableViewUtility: UIScrollViewDelegate {
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		delegate?.scrollViewWillBeginDragging(scrollView)
	}
}
