import UIKit

class TableView: UITableView {	
	override init(frame: CGRect, style: UITableViewStyle) {
		super.init(frame: frame, style: style)
		backgroundColor = Color.White
		estimatedRowHeight = 50.0				// Random value
		estimatedSectionHeaderHeight = 100.0	// Random value
		estimatedSectionFooterHeight = 100.0	// Random value
		rowHeight = UITableViewAutomaticDimension
		sectionHeaderHeight = UITableViewAutomaticDimension
		sectionFooterHeight = UITableViewAutomaticDimension
		separatorStyle = .none
		allowsSelection = false
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
