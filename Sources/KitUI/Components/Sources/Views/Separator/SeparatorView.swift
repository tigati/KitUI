import Foundation
import UIKit

public final class SeparatorView: UIView, IComponent {
	
	var props: Props = .initial
	
	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		switch props.axis {
		case .horizontal:
			return CGSize(width: size.width, height: props.width)
		case .vertical:
			return CGSize(width: props.width, height: size.height)
		}
	}
	
	public func render(props: Separator) {
		self.props = props
		backgroundColor = props.color
	}
}
