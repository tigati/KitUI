import Foundation
import UIKit

/// Добавляет отступы к вложенному компоненту
public struct Padding: IViewProps, Equatable {

	// MARK: - Static

	public static let type: String = String(reflecting: Self.self)

	// MARK: - Public

	/// Вложенный компонент
	public let content: MetaView

	/// Отступы от вложенного компонента
	public let edgeInsets: UIEdgeInsets

	// MARK: - Lifecycle

	public init(
		content: MetaView,
		edgeInsets: UIEdgeInsets
	) {
		self.content = content
		self.edgeInsets = edgeInsets
	}
}
