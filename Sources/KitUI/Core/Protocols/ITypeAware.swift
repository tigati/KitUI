import Foundation

/// Протокол принадлежности к типу
public protocol ITypeAware {

	/// Идентификатор типа
	static var type: String { get }
}
