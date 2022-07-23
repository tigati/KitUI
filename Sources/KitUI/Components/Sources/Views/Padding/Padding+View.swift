import Foundation
import UIKit

extension Padding {
	public typealias View = PaddingView
}

public final class PaddingView: ComponentView, IComponent {

	// MARK: - Private properties

	private var props: Padding?

	private var contentView: UIView?

	// MARK: - Override

	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		guard
			let contentView = contentView,
			let props = props
		else {
			return size
		}

		let sizeToFit = size.inset(by: props.edgeInsets).roundNegativeToZero()

		let contentViewSize = contentView.sizeThatFits(sizeToFit)
		return contentViewSize.offset(by: props.edgeInsets)
	}
	
	public override func hitTest(
		_ point: CGPoint,
		with event: UIEvent?
	) -> UIView? {
		let view = super.hitTest(point, with: event)
		return view == self ? nil : view
	}

	// MARK: - Public methods

	public func render(props: Padding) {
		defer { self.props = props }
		let oldValue = self.props

		if oldValue?.content.type != props.content.type {
			let view = props.content.makeView()
			contentView?.removeFromSuperview()
			contentView = view
			addSubview(view)
		}

		if let contentView = contentView {
			props.content.update(contentView)
			setNeedsLayout()
		}
	}

	// MARK: - Private methods

	public override func layout() {
		guard
			let contentView = contentView,
			let props = props
		else {
			return
		}
		contentView.pin.all(props.edgeInsets)
	}
}
