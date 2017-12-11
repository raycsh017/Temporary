import UIKit
import SnapKit

protocol PrayerListItemViewDelegate: class {
	func prayerListItemView(_ prayerListItemView: PrayerListItemView, didSelectPrayer prayerType: PrayerType)
}

class PrayerListItemView: UIView {
	
	private let kCardWidth: CGFloat = 200.0
	private let kCardHeight: CGFloat = 300.0
	private let kIconHeight: CGFloat = 128.0
	private let kCornerTriangleLength: CGFloat = 30.0
	
	lazy var roundCardView: RoundCardView = {
		let cardView = RoundCardView(frame: .zero)
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
		cardView.addGestureRecognizer(tapGestureRecognizer)
		return cardView
	}()
	
	let cardContentView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.White
		return view
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf20
		label.textColor = Color.Black
		label.textAlignment = .left
		return label
	}()
	
	let iconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	lazy var cardCornerTriangle: UIView = {
		let triangleStartingPoint = CGPoint(x: 0.0, y: 0.0)

		let bezierPath = UIBezierPath()
		bezierPath.move(to: CGPoint(x: triangleStartingPoint.x, y: triangleStartingPoint.y))
		bezierPath.addLine(to: CGPoint(x: triangleStartingPoint.x + self.kCornerTriangleLength, y: triangleStartingPoint.y))
		bezierPath.addLine(to: CGPoint(x: triangleStartingPoint.x + self.kCornerTriangleLength, y: triangleStartingPoint.y + self.kCornerTriangleLength))
		bezierPath.close()
		
		let layer = CAShapeLayer()
		layer.path = bezierPath.cgPath
		
		let view = UIView()
		view.backgroundColor = .blue
		view.layer.mask = layer
		return view
	}()
	
	weak var delegate: PrayerListItemViewDelegate?
	let prayerType: PrayerType

	init(frame: CGRect, prayerType: PrayerType) {
		self.prayerType = prayerType
		super.init(frame: frame)
		
		addSubview(roundCardView)
		
		roundCardView.addCardContentView(cardContentView)
		
		cardContentView.addSubview(titleLabel)
		cardContentView.addSubview(iconImageView)
		cardContentView.addSubview(cardCornerTriangle)
		
		roundCardView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview().inset(UIEdgeInsets.make(withVerticalInset: Spacing.s8, horizontalInset: Spacing.s0))
			make.width.equalTo(kCardWidth)
			make.height.equalTo(kCardHeight)
		}
		
		cardContentView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		
		titleLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s16)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}
		
		iconImageView.snp.makeConstraints { (make) in
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview().offset(-Spacing.s16)
			make.size.equalTo(kIconHeight)
		}
		
		cardCornerTriangle.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.right.equalToSuperview()
			make.size.equalTo(kCornerTriangleLength)
		}
		
		configure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure() {
		titleLabel.text = prayerType.koreanTitle
		iconImageView.image = prayerType.assignedIcon
		cardCornerTriangle.backgroundColor = prayerType.assignedColor
	}
	
	func viewTapped(_ sender: AnyObject) {
		delegate?.prayerListItemView(self, didSelectPrayer: prayerType)
	}
}
