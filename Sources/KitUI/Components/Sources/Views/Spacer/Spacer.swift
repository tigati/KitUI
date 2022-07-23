import Foundation
import UIKit

/// Компонент для гибкого пространства
/// между другими компонентами
public struct Spacer: IViewProps, Equatable, Hashable {
	public typealias View = SpacerView

	// MARK: - Static

	public static let type: String = String(reflecting: Self.self)

	public static let initial = Self(axes: .vertical, length: nil)

	// MARK: - Public properties

	public let axes: Axis.Set
	
	public let length: Double?

	// MARK: - Lifecycle

	public init(axes: Axis.Set, length: Double?) {
		self.axes = axes
		self.length = length
	}
}
