import Foundation
import UIKit

public final class SurfaceView: UIView, IComponent {
	// MARK: - Lifecycle

	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	public override class var layerClass: AnyClass { return CAGradientLayer.self }

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		size
	}
	
	public override func hitTest(
		_ point: CGPoint,
		with event: UIEvent?
	) -> UIView? {
		let view = super.hitTest(point, with: event)
		return view == self ? nil : view
	}
	
	public func render(props: Surface) {
		switch props.fill {
		case .solid(let color):
			let layer = self.layer as! CAGradientLayer
			layer.colors = []
			layer.startPoint = .zero
			layer.endPoint = .zero
			layer.backgroundColor = color.cgColor
		case .gradient(let gradient):
			let layer = self.layer as! CAGradientLayer
			layer.colors = gradient.colors.map { $0.cgColor }
			layer.locations = gradient.locations.map { NSNumber(value: $0) }
			layer.startPoint = gradient.startPoint
			layer.endPoint = gradient.endPoint
		}
		
		layer.cornerRadius = props.radius
		if #available(iOS 13.0, *) {
			layer.cornerCurve = .continuous
		}
		
		if let border = props.border {
			layer.borderColor = border.color.cgColor
			layer.borderWidth = border.width
		} else {
			layer.borderColor = nil
			layer.borderWidth = 0
		}
	}
}
