import Foundation
import UIKit

extension FillParent {
	public typealias View = FillParentView
}

public final class FillParentView: ComponentView, IComponent {
	
	// MARK: - Private properties
	
	private var props: FillParent?
	
	private var contentView: UIView?
	
	// MARK: - Override
	
	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		guard
			let contentView = contentView,
			let props = props
		else {
			return size
		}
		let contentViewSize = contentView.sizeThatFits(size)
		var height: CGFloat = contentViewSize.height
		var width: CGFloat = contentViewSize.width
		if props.axes.contains(.vertical) {
			height = size.height
		}
		if props.axes.contains(.horizontal) {
			width = size.width
		}
		
		return CGSize(width: width, height: height)
	}
	
	public override func hitTest(
		_ point: CGPoint,
		with event: UIEvent?
	) -> UIView? {
		let view = super.hitTest(point, with: event)
		return view == self ? nil : view
	}
	
	// MARK: - Public methods
	
	public func render(props: FillParent) {
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
		contentView?.pin.all()
	}
}
