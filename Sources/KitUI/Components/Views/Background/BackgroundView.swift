import Foundation
import UIKit

public final class BackgroundView: ComponentView, IComponent {
	
	private var contentView: UIView?
	
	private var backgroundView: UIView?
	
	private var props: Background?
	
	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		contentView?.sizeThatFits(size) ?? .zero
	}
	
	public override func hitTest(
		_ point: CGPoint,
		with event: UIEvent?
	) -> UIView? {
		let view = super.hitTest(point, with: event)
		return view == self ? nil : view
	}
	
	public func render(props: Background) {
		defer { self.props = props }
		let oldValue = self.props
		
		if oldValue?.background.type != props.background.type {
			let view = props.background.makeView()
			backgroundView?.removeFromSuperview()
			backgroundView = view
			addSubview(view)
		}
		
		if oldValue?.content.type != props.content.type {
			let view = props.content.makeView()
			contentView?.removeFromSuperview()
			contentView = view
			backgroundView?.addSubview(view)
			backgroundView?.clipsToBounds = true
		}
		
		if let contentView = contentView {
			props.content.update(contentView)
			bringSubviewToFront(contentView)
		}
		
		if let backgroundView = backgroundView {
			props.background.update(backgroundView)
		}
		
		setNeedsLayout()
	}
	
	public override func layout() {
		backgroundView?.pin.all()
		contentView?.pin.all()
	}
}
