import UIKit
import SnapKit

class TableViewController: ViewController, TableViewUtilityDelegate {

	// MARK: View Components
	let tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = Color.White
		tableView.estimatedRowHeight = 30.0	// Random value
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.separatorStyle = .none
		tableView.allowsSelection = false
		return tableView
	}()
	
	let tableViewUtility: TableViewUtility

	override init() {
		tableViewUtility = TableViewUtility(tableView: tableView)
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		safeAreaView.addSubview(tableView)
		
		tableView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		
		tableViewUtility.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) {
		fatalError("tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) has not been implemented")
	}
}

extension TableViewController {
	func setHeaderView(_ view: UIView) {
		view.layoutIfNeeded()
		
		let defaultWidth = UIScreen.main.bounds.width
		let defaultHeight = UILayoutFittingCompressedSize.height
		let frame = view.systemLayoutSizeFitting(CGSize(width: defaultWidth, height: defaultHeight))
		
		view.frame.size.height = frame.height
		tableView.tableHeaderView = view
		tableView.layoutIfNeeded()
	}
}
