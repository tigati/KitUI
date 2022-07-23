import Foundation
import UIKit

public final class FixedSizeView: ComponentView, IComponent {
	
	private var props: FixedSize?
	
	private var contentView: UIView?
	
	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		guard
			let contentView = contentView,
			let props = props
		else {
			return size
		}
		var width: CGFloat = size.width
		var height: CGFloat = size.height

		if props.vertical {
			height = 0
		}

		if props.horizontal {
			width = 0
		}

		return contentView.sizeThatFits(
			CGSize(width: width, height: height)
		)
	}
	
	public func render(props: FixedSize) {
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
	
	public override func layout() {
		guard
			let contentView = contentView
		else {
			return
		}
		contentView.pin.all()
	}
}
