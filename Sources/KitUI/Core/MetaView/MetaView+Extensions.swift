import Foundation

public extension MetaView {
	func id(_ value: String) -> MetaView {
		copy(id: value)
	}
	
	func layoutPriority(_ value: Int) -> MetaView {
		copy(layoutPriority: value)
	}
	
	func isHidden(_ value: Bool) -> MetaView {
		copy(isHidden: value)
	}
	
	func transitionAnimation(duration: Double?) -> MetaView {
		copy(transitionAnimationDuration: duration)
	}
}
