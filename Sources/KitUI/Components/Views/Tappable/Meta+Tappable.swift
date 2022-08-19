import Foundation

extension MetaView {
	public static func tappable(
		_ content: MetaView,
		onTap: ViewCommand?,
		onHighlight: MetaView? = nil,
		onDisable: MetaView? = nil,
		isEnabled: Bool = true,
		style: Tappable.Style
	) -> MetaView {
		.init(
			props: Tappable(
				content: content,
				onTap: onTap,
				onHighlight: onHighlight,
				onDisable: onDisable,
				isEnabled: isEnabled,
				style: style
			)
		)
	}
	
	public func onTap(
		onTap: ViewCommand?,
		onHighlight: MetaView? = nil,
		onDisable: MetaView? = nil,
		isEnabled: Bool = true,
		style: Tappable.Style
	) -> MetaView {
		return .tappable(
			self,
			onTap: onTap,
			onHighlight: onHighlight,
			onDisable: onDisable,
			isEnabled: isEnabled,
			style: style
		)
	}
}
