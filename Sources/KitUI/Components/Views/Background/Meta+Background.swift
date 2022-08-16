import Foundation

public extension MetaView {
	func background(_ value: MetaView) -> MetaView {
		.init(
			props: Background(
				content: self,
				background: value
			)
		)
	}
}
