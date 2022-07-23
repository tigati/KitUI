import Foundation
import UIKit

public extension MetaView {
	/// Меняет `padding`
	/// - Parameter value: Значения `padding`
	/// - Returns: `MetaView` с `padding`
	func padding(_ value: UIEdgeInsets) -> MetaView {
		return .init(
			props: Padding(content: self, edgeInsets: value)
		)
	}
	
	/// Меняет `padding`
	/// - Parameter value: Значения `padding`
	/// - Returns: `MetaView` с `padding`
	func padding(_ value: CGFloat) -> MetaView {
		let insets = UIEdgeInsets(
			top: value,
			left: value,
			bottom: value,
			right: value
		)
		return padding(insets)
	}
	
	/// Меняет `padding`
	/// - Parameter padding: Значения `padding`
	/// - Returns: `MetaView` с `padding`
	func padding(
		top: CGFloat = .zero,
		left: CGFloat = .zero,
		bottom: CGFloat = .zero,
		right: CGFloat = .zero
	) -> MetaView {
		let insets = UIEdgeInsets(
			top: top,
			left: left,
			bottom: bottom,
			right: right
		)
		return padding(insets)
	}
	
	func padding(
		horizontal: CGFloat,
		vertical: CGFloat
	) -> MetaView {
		let insets = UIEdgeInsets(
			top: vertical,
			left: horizontal,
			bottom: vertical,
			right: horizontal
		)
		return padding(insets)
	}
	
	func padding(
		horizontal: CGFloat
	) -> MetaView {
		let insets = UIEdgeInsets(
			top: 0,
			left: horizontal,
			bottom: 0,
			right: horizontal
		)
		return padding(insets)
	}
	
	func padding(
		vertical: CGFloat
	) -> MetaView {
		let insets = UIEdgeInsets(
			top: vertical,
			left: 0,
			bottom: vertical,
			right: 0
		)
		return padding(insets)
	}
}
