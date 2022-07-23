import Foundation
import UIKit

public final class SafeAreaView: UIView, IComponent {
	
	// MARK: - Private properties
	
	private var props: SafeArea?
	
	private var contentView: UIView?
	
	// MARK: - Lifecycle
	
	public init() {
		super.init(frame: .zero)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Override
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}
	
	public override func hitTest(
		_ point: CGPoint,
		with event: UIEvent?
	) -> UIView? {
		let view = super.hitTest(point, with: event)
		return view == self ? nil : view
	}
	
	// MARK: - Public methods
	
	public func render(props: SafeArea) {
		defer { self.props = props }
		let oldValue = self.props
		
		if oldValue?.content.type != props.content.type {
			let view = props.content.makeView()
			contentView?.removeFromSuperview()
			contentView = view
			addSubview(view)
		}
		
		if
			oldValue != props,
			let contentView = contentView
		{
			props.content.update(contentView)
			setNeedsLayout()
		}
	}
	
	// MARK: - Private methods
	
	private func layout() {
		guard let props = props else { return }
		var top: CGFloat = 0
		var bottom: CGFloat = 0
		var left: CGFloat = 0
		var right: CGFloat = 0
		if props.edges.contains(.top) {
			top = pin.safeArea.top
		}
		if props.edges.contains(.bottom) {
			bottom = pin.safeArea.bottom
		}
		if props.edges.contains(.leading) {
			left = pin.safeArea.left
		}
		if props.edges.contains(.trailing) {
			right = pin.safeArea.right
		}
		contentView?
			.pin
			.top(top)
			.bottom(bottom)
			.left(left)
			.right(right)
	}
}
