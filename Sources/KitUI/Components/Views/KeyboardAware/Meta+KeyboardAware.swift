import Foundation

public extension MetaView {
	func keyboardAware() -> MetaView {
		.init(
			props: KeyboardAware(content: self)
		)
	}
}
