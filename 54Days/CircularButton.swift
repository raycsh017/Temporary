class CircularButton: Button {
	override func layoutSubviews() {
		super.layoutSubviews()

		layer.cornerRadius = bounds.height / 2.0
	}
}
