import UIKit

class TableView: UITableView {	
	override init(frame: CGRect, style: UITableViewStyle) {
		super.init(frame: frame, style: style)
		setupWithDefaultSettings()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupWithDefaultSettings() {
		backgroundColor = Color.White
		estimatedRowHeight = 30.0	// Random value
		rowHeight = UITableViewAutomaticDimension
		separatorStyle = .none
	}
}
