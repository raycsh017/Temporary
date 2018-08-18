import UIKit
import SnapKit

class TableViewController: ViewController {

	private var didSetupKeyboardEventObservers: Bool = false
	private var contentInsetBeforeKeyboardDidShow: UIEdgeInsets?
	private var fixedHeaderViewHeightConstraint: Constraint?
	private var fixedFooterViewHeightConstraint: Constraint?

	var adjustContentInsetOnKeyboardEvents: Bool = false {
		willSet {
			if newValue {
				setupKeyboardObservers()
			} else {
				removeKeyboardObservers()
			}
		}
	}

	var dismissKeyboardOnScroll: Bool = false

	// MARK: View Components

	let fixedHeaderContainerView = UIView()
	let fixedFooterContainerView = UIView()

	let tableView: TableView = {
		let tableView = TableView()
		return tableView
	}()

	lazy var tableViewUtility: TableViewUtility = {
		let tableViewUtility = TableViewUtility(tableView: self.tableView)
		tableViewUtility.delegate = self
		return tableViewUtility
	}()

	override init() {
		super.init()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		safeAreaView.addSubview(tableView)
		safeAreaView.addSubview(fixedHeaderContainerView)
		safeAreaView.addSubview(fixedFooterContainerView)

		fixedHeaderContainerView.setContentHuggingPriority(.required, for: .vertical)
		fixedHeaderContainerView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			fixedHeaderViewHeightConstraint = make.height.equalTo(0).constraint
		}
		fixedHeaderViewHeightConstraint?.activate()

		fixedFooterContainerView.setContentHuggingPriority(.required, for: .vertical)
		fixedFooterContainerView.snp.makeConstraints { (make) in
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
			fixedFooterViewHeightConstraint = make.height.equalTo(0).constraint
		}
		fixedFooterViewHeightConstraint?.activate()

		tableView.snp.makeConstraints { (make) in
			make.top.equalTo(fixedHeaderContainerView.snp.bottom)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalTo(fixedFooterContainerView.snp.top)
		}
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if adjustContentInsetOnKeyboardEvents {
			setupKeyboardObservers()
		}
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		if adjustContentInsetOnKeyboardEvents {
			removeKeyboardObservers()
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	private func setupKeyboardObservers() {
		guard !didSetupKeyboardEventObservers else {
			return
		}
		didSetupKeyboardEventObservers = true
		NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
	}

	private func removeKeyboardObservers() {
		guard didSetupKeyboardEventObservers else {
			return
		}
		didSetupKeyboardEventObservers = false
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
	}

	@objc func onKeyboardDidShow(_ notification: NSNotification) {
		guard let userInfo = notification.userInfo,
			let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
			return
		}

		contentInsetBeforeKeyboardDidShow = tableView.contentInset

		let keyboardHeight = keyboardFrame.height
		tableView.contentInset.bottom = keyboardHeight
		tableView.scrollIndicatorInsets.bottom = keyboardHeight
	}

	@objc func onKeyboardWillHide(_ notification: NSNotification) {
		if let contentInset = contentInsetBeforeKeyboardDidShow {
			tableView.contentInset.bottom = contentInset.bottom
			tableView.scrollIndicatorInsets.bottom = 0.0
		}
	}

	func reloadData(withCellConfigurators cellConfigurators: [CellConfiguratorType]) {
		tableViewUtility.register(cells: cellConfigurators)
		tableViewUtility.reloadData()
	}
}

extension TableViewController {
	func setHeaderView(_ view: UIView, fixedToTop: Bool = false) {
		if fixedToTop {
			fixedHeaderViewHeightConstraint?.deactivate()
			fixedHeaderContainerView.addSubview(view)
			view.snp.makeConstraints { (make) in
				make.edges.equalToSuperview()
			}
		} else {
			tableViewUtility.setHeaderView(view)
		}
	}

	func setFooterView(_ view: UIView, fixedToBottom: Bool = false) {
		if fixedToBottom {
			fixedFooterViewHeightConstraint?.deactivate()
			fixedFooterContainerView.addSubview(view)
			view.snp.makeConstraints { (make) in
				make.edges.equalToSuperview()
			}
		} else {
			tableViewUtility.setFooterView(view)
		}
	}

}

extension TableViewController: TableViewUtilityDelegate {
	@objc func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) {
		fatalError("tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) has not been implemented")
	}

	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		if dismissKeyboardOnScroll {
			view.endEditing(true)
		}
	}
}
