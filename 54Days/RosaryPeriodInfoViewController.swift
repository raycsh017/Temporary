import UIKit
import SnapKit

class RosaryPeriodInfoViewController: ViewController {

	let scrollView: UIScrollView = {
		let scrollView = UIScrollView(frame: CGRect.zero)
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.alwaysBounceVertical = true
		return scrollView
	}()

	let petitionDescriptionView = RosaryPeriodInfoPetitionDescriptionView(frame: CGRect.zero)

	lazy var editButton: Button = {
		let button = Button(frame: CGRect.zero)
		let attributedText = "수정하기".attributed(withFont: Font.f16, textColor: Color.Button.Edit)
		button.setAttributedTitle(attributedText, for: .normal)
		button.backgroundColor = Color.White
		button.applyShadow()
		button.applyCornerRadius()
		button.addTarget(self, action: #selector(onEditButtonTap(_:)), for: .touchUpInside)
		return button
	}()

	let viewModel: RosaryPeriodInfoViewModel

	init(viewModel: RosaryPeriodInfoViewModel, presentationType: ViewController.PresentationType) {
		self.viewModel = viewModel
		super.init(presentationType: presentationType)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		updateNavigationBar(title: "진행중인 묵주기도")
		makeNavigationBarTranslucent()

		// Do any additional setup after loading the view.
		safeAreaView.addSubview(scrollView)
		safeAreaView.addSubview(editButton)

		scrollView.addSubview(petitionDescriptionView)

		scrollView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}

		petitionDescriptionView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s32)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview().offset(-Spacing.s32)
			make.width.equalTo(scrollView.snp.width)
			make.height.greaterThanOrEqualTo(scrollView.snp.height)
		}

		editButton.snp.makeConstraints { (make) in
			make.top.equalTo(scrollView.snp.bottom)
			make.bottom.equalToSuperview().offset(-Spacing.s16)
			make.centerX.equalToSuperview()
			make.width.equalTo(Button.suggestedWidth)
			make.height.equalTo(Button.suggestedHeight)
		}

		viewModel.getPetitionDescriptionViewData { (viewData) in
			self.petitionDescriptionView.update(withViewData: viewData)
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@objc func onEditButtonTap(_ sender: Any) {
		routeToRosaryForm()
	}

}

// MARK: Routing
extension RosaryPeriodInfoViewController {
	private func routeToRosaryForm() {
		let viewModel = RosaryFormViewModel()
		let viewController = RosaryFormViewController(viewModel: viewModel, presentationType: .navigation)
		viewController.delegate = self
		route(to: viewController)
	}
}

extension RosaryPeriodInfoViewController: RosaryFormViewControllerDelegate {
	func rosaryFormViewControllerDidEditForm(_ viewController: RosaryFormViewController) {
		viewModel.getPetitionDescriptionViewData { (viewData) in
			self.petitionDescriptionView.update(withViewData: viewData)
		}
	}
}
