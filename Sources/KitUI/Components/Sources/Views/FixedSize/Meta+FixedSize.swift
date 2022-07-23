import Foundation

extension MetaView {
	public func fixedSize(
		horizontal: Bool,
		vertical: Bool
	) -> MetaView {
		.init(
			props: FixedSize(
				horizontal: horizontal,
				vertical: vertical,
				content: self
			)
		)
	}
}
