import Foundation

/// Компонент-обёртка для размещения
/// вложенного компонента с возможностью задать
/// отступы от SafeArea
public struct SafeArea: IViewProps, Equatable {

	// MARK: - Static

	public static let type: String = String(reflecting: Self.self)

	// MARK: - Public

	/// Компонент-содержимое вкладываемый в `SafeArea`
	public let content: MetaView
	
	public let edges: Edge.Set

	// MARK: - Lifecycle

	public init(
		content: MetaView,
		edges: Edge.Set
	) {
		self.content = content
		self.edges = edges
	}
}

extension SafeArea {
	public typealias View = SafeAreaView
}
