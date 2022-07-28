import Foundation
import UIKit

public final class FixedFrameView: ComponentView, IComponent {
	
	var props: FixedFrame?
	
	var contentView: UIView?
	
	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		guard let props = props else { return size }
		return CGSize(width: props.width, height: props.height)
	}
	
	public override func hitTest(
		_ point: CGPoint,
		with event: UIEvent?
	) -> UIView? {
		let view = super.hitTest(point, with: event)
		return view == self ? nil : view
	}
	
	public func render(props: FixedFrame) {
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
		contentView?.pin.all()
	}
}
