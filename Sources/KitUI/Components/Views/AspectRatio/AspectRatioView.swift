import Foundation
import UIKit

public final class AspectRatioView: ComponentView, IComponent {
	
	var props: AspectRatio?
	
	var contentView: UIView?
	
	public override func hitTest(
		_ point: CGPoint,
		with event: UIEvent?
	) -> UIView? {
		let view = super.hitTest(point, with: event)
		return view == self ? nil : view
	}
	
	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		guard
			let props = props,
			let contentView = contentView
		else {
			return size
		}
		
		let width: CGFloat
		let height: CGFloat
		
		if let ratio = props.ratio {
			width = ratio
			height = 1
		} else {
			let contentSize = contentView.sizeThatFits(.zero)
			width = contentSize.width
			height = contentSize.height
		}
		
		let contentRect = CGRect(
			x: 0,
			y: 0,
			width: width,
			height: height
		)
		
		let target = CGRect(
			x: 0,
			y: 0,
			width: size.width,
			height: size.height
		)
		
		switch props.contentMode {
		case .fit:
			let result = contentRect.aspectFit(in: target)
			return result.size
		case .fill:
			let result = contentRect.aspectFill(in: target).size.limit(with: size)
			return result
		case .fullHeight:
			return CGSize(
				width: width * size.height / height,
				height: size.height
			)
		case .fullWidth:
			return CGSize(
				width: size.width,
				height: height * size.width / width
			)
		}
	}
	
	public func render(props: AspectRatio) {
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
			let props = props,
			let contentView = contentView
		else {
			return
		}

		
		let width: CGFloat
		let height: CGFloat
		
		if let ratio = props.ratio {
			width = ratio
			height = 1
		} else {
			let contentSize = contentView.sizeThatFits(.zero)
			width = contentSize.width
			height = contentSize.height
		}
		
		let contentRect = CGRect(
			x: 0,
			y: 0,
			width: width,
			height: height
		)
		
		let target = CGRect(
			x: 0,
			y: 0,
			width: bounds.size.width,
			height: bounds.size.height
		)
		
		let result: CGSize
		
		switch props.contentMode {
		case .fit:
			result = contentRect.aspectFit(in: target).size
		case .fill:
			result = contentRect.aspectFill(in: target).size
		case .fullHeight:
			result = CGSize(
				width: width * bounds.size.height / height,
				height: bounds.size.height
			)
		case .fullWidth:
			result = CGSize(
				width: bounds.size.width,
				height: height * bounds.size.width / width
			)
		}
		
		contentView.pin.center().size(result)
	}
}
