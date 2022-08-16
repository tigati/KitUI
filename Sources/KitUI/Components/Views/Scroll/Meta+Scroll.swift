import Foundation

extension MetaView {
	public static func vScroll(
		shouldAdjustInsetsForKeyboard: Bool = false,
		_ content: MetaView
	) -> MetaView {
		.init(
			props: Scroll(
				axes: .vertical,
				content: content,
				shouldAdjustInsetsForKeyboard: shouldAdjustInsetsForKeyboard
			)
		)
	}
	
	public static func hScroll(
		shouldAdjustInsetsForKeyboard: Bool = false,
		_ content: MetaView
	) -> MetaView {
		.init(
			props: Scroll(
				axes: .horizontal,
				content: content,
				shouldAdjustInsetsForKeyboard: shouldAdjustInsetsForKeyboard
			)
		)
	}
}
