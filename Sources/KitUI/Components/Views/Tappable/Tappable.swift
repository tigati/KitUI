import Foundation

public struct Tappable: IViewProps, Equatable {

	// MARK: - Static

	public static let type: String = String(reflecting: Self.self)
	
	public typealias View = TappableView

	// MARK: - Public properties

	/// Компонент-содержимое вкладываемый в `Tappable`
	public let content: MetaView
	/// Содержимое при нажатии
	public let onHighlight: MetaView?
	/// Содержимое при неативном состоянии
	public let onDisable: MetaView?

	/// Включено
	public let isEnabled: Bool

	/// Реакция на нажатие
	public let onTap: ViewCommand?

	public var style: Tappable.Style

	// MARK: - Lifecylce

	public init(
		content: MetaView,
		onTap: ViewCommand?,
		onHighlight: MetaView?,
		onDisable: MetaView?,
		isEnabled: Bool,
		style: Style
	) {
		self.content = content
		self.onTap = onTap
		self.onHighlight = onHighlight
		self.onDisable = onDisable
		self.isEnabled = isEnabled
		self.style = style
	}
}
