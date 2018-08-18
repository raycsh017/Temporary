import Foundation
import UIKit

class CellSectionConfigurator {
	var sectionHeaderView: UIView?
	var sectionFooterView: UIView?
	var cellConfigurators: [CellConfiguratorType]
	
	init(cellConfigurators: [CellConfiguratorType],
		 sectionHeaderView: UIView? = nil,
		 sectionFooterView: UIView? = nil) {
		self.cellConfigurators = cellConfigurators
		self.sectionHeaderView = sectionHeaderView
		self.sectionFooterView = sectionFooterView
	}
}
