import Foundation

/// Компонент Navigation (использует `UINavigationController`)
public struct Navigation: IViewProps, Equatable {
	

	// MARK: - Static

	public static let type: String = String(reflecting: Self.self)

	public static let initial = Navigation(
		stack: [],
		onPop: .empty,
		progress: nil
	)

	// MARK: - Public

	/// Стек из `ViewController` для отображения.
	public let stack: [MetaVC]

	/// Вызывается при переходе назад.
	/// Возвращает количество оставшихся `ViewController` в стеке
	public let onPop: ViewCommandWith<Int>
	
	public let progress: Float?

	// MARK: - Lifecycle

	public init(
		stack: [MetaVC],
		onPop: ViewCommandWith<Int>,
		progress: Float?
	) {
		self.stack = stack
		self.onPop = onPop
		self.progress = progress
	}
}

extension Navigation {
	public typealias View = NavigationViewController
}
