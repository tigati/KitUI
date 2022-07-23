import Foundation

/// Протокол идентификации
public protocol IIdentifiable {
	
	associatedtype ID : Hashable

	/// Индентификатор
	var id: Self.ID { get }
}
