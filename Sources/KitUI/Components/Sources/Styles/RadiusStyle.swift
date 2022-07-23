import UIKit

/// Стиль скругления
public struct RadiusStyle: Equatable {

	/// Набор углов, которые необходимо скуглить
	public let corners: UIRectCorner

	/// Значение скругления
	public let radii: CGSize

	// MARK: - Lifecycle

	/// - Parameters:
	///		- id: Идентификатор
	/// 	- corners: Набор углов, которые необходимо скуглить
	///		- radii: Значение скругления
	public init(
		corners: UIRectCorner,
		radii: CGSize
	) {
		self.corners = corners
		self.radii = radii
	}
}
