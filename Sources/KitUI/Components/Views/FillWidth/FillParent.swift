import Foundation

/// Заполняет всё доступное пространство по ширине
public struct FillParent: IViewProps, Equatable {

	// MARK: - Static

	public static let type: String = String(reflecting: Self.self)

	// MARK: - Public
	
	public let axes: Axis.Set

	public let content: MetaView

	// MARK: - Static

	public init(axes: Axis.Set, content: MetaView) {
		self.axes = axes
		self.content = content
	}
}
