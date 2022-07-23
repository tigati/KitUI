import Foundation
import UIKit

public extension MetaView {
	/// Компонент VStack
	static func vStack(
		spacing: CGFloat = .zero,
		alignment: HorizontalAlignment = .center,
		_ items: MetaView...
	) -> MetaView {
		vStack(
			spacing: spacing,
			alignment: alignment,
			items
		)
	}
	
	/// Компонент VStack
	static func vStack(
		spacing: CGFloat = .zero,
		alignment: HorizontalAlignment = .center,
		_ items: [MetaView]
	) -> MetaView {
		.init(
			props: Stack(
				items: items,
				axis: .vertical,
				spacing: spacing,
				alignment: .init(
					horizontal: alignment,
					vertical: .center
				)
			)
		)
	}
	
	/// Компонент HStack
	static func hStack(
		spacing: CGFloat = .zero,
		alignment: VerticalAlignment = .center,
		_ items: MetaView...
	) -> MetaView {
		.hStack(
			spacing: spacing,
			alignment: alignment,
			items
		)
	}
	
	/// Компонент HStack
	static func hStack(
		spacing: CGFloat = .zero,
		alignment: VerticalAlignment = .center,
		_ items: [MetaView]
	) -> MetaView {
		.init(
			props: Stack(
				items: items,
				axis: .horizontal,
				spacing: spacing,
				alignment: .init(horizontal: .center, vertical: alignment)
			)
		)
	}
}
