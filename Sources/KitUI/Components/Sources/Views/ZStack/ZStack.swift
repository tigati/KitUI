import UIKit

/// Стек из компонентов
public struct ZStack: IViewProps, Equatable {

	// MARK: - Static

	public static let initial = ZStack(
		items: []
	)

	public static let type: String = String(reflecting: Self.self)
	
	public typealias View = ZStackView

	// MARK: - Internal properties

	public let items: [MetaView]

	public let alignment: Alignment
	

	// MARK: - Lifecycle

	public init(
		items: [MetaView],
		alignment: Alignment = .initial
	) {
		self.items = items
		self.alignment = alignment
	}
}
