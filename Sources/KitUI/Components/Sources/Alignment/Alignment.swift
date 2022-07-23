import Foundation

/// Выравнивание
public struct Alignment: Equatable {

	// MARK: - Static

	public static let initial = Alignment(
		horizontal: .center,
		vertical: .center
	)
	
	public static let topLeading = Alignment(
		horizontal: .leading,
		vertical: .top
	)
	
	public static let leading = Alignment(
		horizontal: .leading,
		vertical: .center
	)
	
	public static let bottomLeading = Alignment(
		horizontal: .leading,
		vertical: .bottom
	)
	
	public static let top = Alignment(
		horizontal: .center,
		vertical: .top
	)
	
	public static let center = Alignment(
		horizontal: .center,
		vertical: .center
	)
	
	public static let bottom = Alignment(
		horizontal: .center,
		vertical: .bottom
	)
	
	public static let topTrailing = Alignment(
		horizontal: .trailing,
		vertical: .top
	)
	
	public static let trailing = Alignment(
		horizontal: .trailing,
		vertical: .center
	)
	
	public static let bottomTrailing = Alignment(
		horizontal: .trailing,
		vertical: .bottom
	)

	/// Выравнивание по горизонтали
	public let horizontal: HorizontalAlignment

	/// Выравнивание по вертикали
	public let vertical: VerticalAlignment

	// MARK: - Lifecycle

	/// Инициализация
	public init(
		horizontal: HorizontalAlignment,
		vertical: VerticalAlignment
	) {
		self.horizontal = horizontal
		self.vertical = vertical
	}
}
