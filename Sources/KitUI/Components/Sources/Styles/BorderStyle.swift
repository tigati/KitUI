import UIKit

/// Стиль границы
public struct BorderStyle: Equatable {

	/// Толщина линии границы
	public let width: CGFloat

	/// Цвет линии границы
	public let color: UIColor

	// MARK: - Lifecycle

	/// - Parameters:
	///		- id: Идентификатор
	///		- width: Толщина линии границы
	///		- color: Цвет линии границы
	public init(
		width: CGFloat,
		color: UIColor
	) {
		self.width = width
		self.color = color
	}
}
