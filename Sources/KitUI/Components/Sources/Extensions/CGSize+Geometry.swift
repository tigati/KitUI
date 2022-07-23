import UIKit

public extension CGSize {

	/// Возвращает новый размер, уменьшенный на значение инсетов
	/// - Parameters:
	///		- insets: Инсеты
	/// - Returns: Новый размер
	func inset(by insets: UIEdgeInsets) -> CGSize {
		CGSize(
			width: width - insets.left - insets.right,
			height: height - insets.top - insets.bottom
		)
	}

	/// Возвращает новый размер, увеличенный на значение инсетов
	/// - Parameters:
	///		- insets: Инсеты
	/// - Returns: Новый размер
	func offset(by insets: UIEdgeInsets) -> CGSize {
		return CGSize(
			width: width + insets.left + insets.right,
			height: height + insets.top + insets.bottom
		)
	}

	/// Возвращает новый размер ограниченный заданным.
	/// ширина и длина находятся в рамках заданного размера
	/// - Parameter size: Ограничивающий размер
	/// - Returns: Новый размер
	func limit(with size: CGSize) -> CGSize {
		return CGSize(
			width: min(width, size.width),
			height: min(height, size.height)
		)
	}
	
	/// Округление отрицательного значения до нуля
	func roundNegativeToZero() -> CGSize {
		return CGSize(
			width: (abs(width) + width) / 2,
			height: (abs(height) + height) / 2
		)
	}
}
