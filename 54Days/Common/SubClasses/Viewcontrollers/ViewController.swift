import Foundation
import UIKit
import SnapKit

class ViewController: UIViewController {
	
	var statusBarHeight: CGFloat {
		return UIApplication.shared.statusBarFrame.height
	}
	
	let safeAreaView: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		return view
	}()
	
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
			make.top.equalToSuperview().offset(statusBarHeight)
			make.bottom.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
	}
}