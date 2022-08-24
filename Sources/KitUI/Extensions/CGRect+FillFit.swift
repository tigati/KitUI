import Foundation
import UIKit

public extension CGRect {
	
	func scaleToAspectFit(in target: CGRect) -> CGFloat {
		// first try to match width
		let s = target.width / self.width;
		// if we scale the height to make the widths equal, does it still fit?
		if self.height * s <= target.height {
			return s
		}
		// no, match height instead
		return target.height / self.height
	}
	
	func aspectFit(in target: CGRect) -> CGRect {
		let s = scaleToAspectFit(in: target)
		let w = width * s
		let h = height * s
		let x = target.midX - w / 2
		let y = target.midY - h / 2
		return CGRect(x: x, y: y, width: w, height: h)
	}

	func scaleToAspectFill(in target: CGRect) -> CGFloat {
		// fit in the target inside the rectangle instead, and take the reciprocal
		return 1 / target.scaleToAspectFit(in: self)
	}
	
	func aspectFill(in target: CGRect) -> CGRect {
		let s = scaleToAspectFill(in: target)
		let w = width * s
		let h = height * s
		let x = target.midX - w / 2
		let y = target.midY - h / 2
		return CGRect(x: x, y: y, width: w, height: h)
	}
}
