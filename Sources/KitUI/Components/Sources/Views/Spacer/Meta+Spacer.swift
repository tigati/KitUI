import Foundation

extension MetaView {
	public static func spacer(axes: Axis.Set, length: Double?) -> MetaView {
		MetaView(
			props: Spacer(
				axes: axes,
				length: length
			)
		)
	}
	
	public static func vSpacer(_ length: Double?) -> MetaView {
		.spacer(axes: .vertical, length: length)
	}
	
	public static func hSpacer(_ length: Double?) -> MetaView {
		.spacer(axes: .horizontal, length: length)
	}
	
	public static let vSpacer = vSpacer(nil).layoutPriority(-10)
	
	public static let hSpacer = hSpacer(nil).layoutPriority(-10)
}
