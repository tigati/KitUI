import Foundation
import UIKit

// Протокол для доступа к customContentView и margins
protocol ICollectionCellView: UICollectionViewCell {
	var customContentView: UIView { get }
}


class CollectionCellView<TContentView: UIView>: UICollectionViewCell, ICollectionCellView {
	
	// MARK: - Internal properties

	let customContentView: UIView = TContentView()

	// MARK: - Lifecycle

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}

	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		return customContentView.sizeThatFits(size)
	}

	// MARK: - Private methods

	private func setup() {
		backgroundView = nil
		backgroundColor = .clear
		contentView.addSubview(customContentView)
	}

	private func layout() {
		customContentView.pin.all()
	}
}
