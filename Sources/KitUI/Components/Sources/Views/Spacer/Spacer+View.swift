import PinLayout
import UIKit

public final class SpacerView: UIView, IComponent {

	// MARK: - Private properties

	private var props: Spacer = .initial

	// MARK: - Lifecycle

	public init() {
		super.init(frame: .zero)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Override

	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		var sizeThatFits = CGSize()
		if props.axes.contains(.vertical) {
			sizeThatFits.height = props.length ?? size.height
		}
		if props.axes.contains(.horizontal) {
			sizeThatFits.width = props.length ?? size.width
		}
		return sizeThatFits
	}

	// MARK: - Private methods

	private func setup() {
		isHidden = true
	}

	// MARK: - Public methods

	public func render(props: Spacer) {
		self.props = props
	}
}
