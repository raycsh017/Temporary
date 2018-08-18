import Foundation
import UIKit
import SnapKit

class ViewController: UIViewController {
	
	private lazy var viewTapGestureRecognizer: UITapGestureRecognizer = {
		return UITapGestureRecognizer(target: self, action: #selector(onViewTap(_:)))
	}()
	
	lazy var navigationBar: UINavigationBar = {
		let navBar = UINavigationBar(frame: CGRect.zero)
		navBar.shadowImage = UIImage()
		navBar.setBackgroundImage(UIImage(), for: .default)
		return navBar
	}()

	let safeAreaView: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		return view
	}()

	var endEditingOnTap: Bool = false {
		didSet {
			reSetupGestureRecognizers()
		}
	}

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = Color.White

		view.addSubview(safeAreaView)

		safeAreaView.snp.makeConstraints { (make) in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
			make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
		}
		
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

	func setupNavigationBar(withTitle title: String, leftButtonType: NavigationButtonType? = nil, rightButtonType: NavigationButtonType? = nil) {
		addNavigationBarToView()

		let navigationItem = UINavigationItem(title: title)

		if let leftButtonType = leftButtonType {
			let leftBarButtonItem = UIBarButtonItem(image: leftButtonType.image, style: .plain, target: self, action: #selector(onLeftNavigationButtonTap(_:)))
			navigationItem.leftBarButtonItem = leftBarButtonItem
		}

		if let rightButtonType = rightButtonType {
			let rightBarButtonItem = UIBarButtonItem(image: rightButtonType.image, style: .plain, target: self, action: #selector(onRightNavigationButtonTap(_:)))
			navigationItem.rightBarButtonItem = rightBarButtonItem
		}

		navigationBar.setItems([navigationItem], animated: false)
	}

	private func addNavigationBarToView() {
		view.addSubview(navigationBar)

		navigationBar.snp.makeConstraints { (make) in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
			make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
			make.height.equalTo(Size.NavigationBar.height)
		}

		safeAreaView.snp.remakeConstraints { (make) in
			make.top.equalTo(navigationBar.snp.bottom)
			make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
			make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
		}
	}
	
	private func reSetupGestureRecognizers() {
		view.removeGestureRecognizer(viewTapGestureRecognizer)

		if endEditingOnTap {
			view.addGestureRecognizer(viewTapGestureRecognizer)
		}
	}

	@objc func onLeftNavigationButtonTap(_ sender: Any) {
		dismiss(animated: true, completion: nil)
		return
	}

	@objc func onRightNavigationButtonTap(_ sender: Any) {
		return
	}

	@objc func onViewTap(_ sender: Any) {
		view.endEditing(true)
	}
}

enum NavigationButtonType {
	case x
	
	var image: UIImage? {
		switch self {
		case .x:
			return #imageLiteral(resourceName: "ic_x")
		}
	}
}
