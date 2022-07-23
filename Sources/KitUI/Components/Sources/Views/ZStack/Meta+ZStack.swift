import Foundation

extension MetaView {
	public static func zStack(
		alignment: Alignment = .initial,
		_ items: [MetaView]
	) -> MetaView {
		.init(
			props: ZStack(
				items: items,
				alignment: alignment
			)
		)
	}
	
	public static func zStack(
		alignment: Alignment = .initial,
		_ items: MetaView...
	) -> MetaView {
		.zStack(alignment: alignment, items)
	}
}
