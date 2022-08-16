import Foundation

/// Обёртка для других компонентов
public struct Scroll: IViewProps, Equatable {

	public typealias View = ScrollView

	public static let type: String = String(reflecting: Self.self)

	// MARK: - Public properties

	public let axes: Axis.Set

	/// Компонент-содержимое вкладываемый в `Scroll`
	public let content: MetaView
	
	public let shouldAdjustInsetsForKeyboard: Bool

	// MARK: - Lifecycle

	public init(
		axes: Axis.Set = .vertical,
		content: MetaView,
		shouldAdjustInsetsForKeyboard: Bool
	) {
		self.axes = axes
		self.content = content
		self.shouldAdjustInsetsForKeyboard = shouldAdjustInsetsForKeyboard
	}
}
