import Foundation
import UIKit
import SnapKit

class ViewController: UIViewController {

	enum PresentationType {
		case modal
		case navigation
	}

	let presentationType: PresentationType

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

	init(presentationType: PresentationType) {
		self.presentationType = presentationType
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
		let navItem: UINavigationItem
		if navigationController == nil {
			addNavigationBarToView()
			navItem = UINavigationItem(title: title)
			navigationBar.setItems([navItem], animated: false)
		} else {
			navItem = navigationItem
			navItem.title = title
		}

		var leftBarButtonItem: UIBarButtonItem?
		if let leftButtonType = leftButtonType {
			switch leftButtonType {
			case let .text(title):
				leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(onLeftNavigationButtonTap(_:)))
			case let .icon(iconType):
				let button = Button(frame: CGRect(x: 0, y: 0, width: 36.0, height: 36.0))
				button.layer.cornerRadius = CornerRadius.Button.RoundRect
				button.setImage(iconType.image, for: .normal)
				button.addTarget(self, action: #selector(onLeftNavigationButtonTap(_:)), for: .touchUpInside)
				leftBarButtonItem = UIBarButtonItem(customView: button)
			}
			navItem.leftBarButtonItem = leftBarButtonItem
		}

		var rightBarButtonItem: UIBarButtonItem?
		if let rightButtonType = rightButtonType {
			switch rightButtonType {
			case let .text(title):
				rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(onRightNavigationButtonTap(_:)))
			case let .icon(iconType):
				let button = Button(frame: CGRect(x: 0, y: 0, width: 36.0, height: 36.0))
				button.layer.cornerRadius = CornerRadius.Button.RoundRect
				button.setImage(iconType.image, for: .normal)
				button.addTarget(self, action: #selector(onRightNavigationButtonTap(_:)), for: .touchUpInside)
				rightBarButtonItem = UIBarButtonItem(customView: button)
			}
			navItem.rightBarButtonItem = rightBarButtonItem
		}
	}

	func makeNavigationBarTranslucent() {
		let navBar = navigationController?.navigationBar ?? navigationBar
		navBar.setBackgroundImage(UIImage(), for: .default)
		navBar.shadowImage = UIImage()
		navBar.isTranslucent = true
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
		routeBack()
		return
	}

	@objc func onRightNavigationButtonTap(_ sender: Any) {
		return
	}

	@objc func onViewTap(_ sender: Any) {
		view.endEditing(true)
	}
}

// MARK: - Routing
extension ViewController {
	func routeBack() {
		switch presentationType {
		case .modal:
			dismiss(animated: true, completion: nil)
		case .navigation:
			navigationController?.popViewController(animated: true)
		}
	}

	func dismissNavigationController() {
		navigationController?.dismiss(animated: true, completion: nil)
	}
}

enum NavigationButtonType {
	case text(title: String)
	case icon(iconType: IconType)

	enum IconType {
		case x
		case leftChevron

		var image: UIImage? {
			switch self {
			case .x:
				return #imageLiteral(resourceName: "ic_x")
			case .leftChevron:
				return #imageLiteral(resourceName: "ic_chevron_left")
			}
		}
	}
}
