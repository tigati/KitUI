import Foundation
import UIKit

/// Стек из компонентов
/// Нет собственного представления.
/// Используется для лейаута других компонентов.
public struct Stack: IViewProps, Equatable {

	// MARK: - Static

	public static let initial = Stack(
		items: [],
		axis: .horizontal,
		spacing: .initial,
		alignment: .initial
	)

	// MARK: - Public properties

	public static let type: String = String(reflecting: Stack.self)

	/// Элементы стека.
	public let items: [MetaView]

	/// Продольная ось стека.
	public let axis: Axis

	/// Расстояние между элементами.
	public let spacing: CGFloat

	/// Выравнивание элементов.
	/// Начальное значение `center`.
	public let alignment: Alignment

	// MARK: - Lifecycle

	public init(
		items: [MetaView],
		axis: Axis,
		spacing: CGFloat,
		alignment: Alignment
	) {
		self.items = items
		self.axis = axis
		self.spacing = spacing
		self.alignment = alignment
	}
}

extension Stack {
	public typealias View = StackView
}
