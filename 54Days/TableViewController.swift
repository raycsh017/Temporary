import UIKit
import SnapKit

class TableViewController: UIViewController {

	// MARK: View Components
	let tableView: UITableView = {
		let tableview = UITableView()
		tableview.backgroundColor = Color.BackgroundGray
		tableview.estimatedRowHeight = 30.0	// Random value
		tableview.rowHeight = UITableViewAutomaticDimension
		tableview.separatorStyle = .none
		tableview.allowsSelection = false
		return tableview
	}()
	let tableViewUtility: TableViewUtility

	init() {
		tableViewUtility = TableViewUtility(tableView: tableView)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		view.backgroundColor = Color.BackgroundGray
		
		view.addSubview(tableView)
		
		tableView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		tableViewUtility.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TableViewController: TableViewUtilityDelegate {
	func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) {
		fatalError("tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) has not been implemented")
	}
}
