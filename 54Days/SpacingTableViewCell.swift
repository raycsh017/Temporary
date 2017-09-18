import UIKit
import SnapKit

struct SpacingDisplayData {
	let spacing: Int
	
	init(_ spacing: Int) {
		self.spacing = spacing
	}
}

class SpacingTableViewCell: UITableViewCell {
	
	var heightConstraint: Constraint?
	
	var spacingDisplayData: SpacingDisplayData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		backgroundColor = UIColor.clear
		contentView.backgroundColor = UIColor.clear
		
		contentView.snp.makeConstraints { (make) in
			heightConstraint = make.height.equalTo(0).constraint
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension SpacingTableViewCell: CellUpdatable {
	typealias CellData = SpacingDisplayData
	
	func update(withCellData cellData: SpacingDisplayData) {
		spacingDisplayData = cellData
		
		heightConstraint?.update(offset: cellData.spacing)
	}
}
