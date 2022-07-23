import Foundation
import UIKit

public struct Surface: IViewProps, Equatable {
	
	public typealias View = SurfaceView
	
	public static let type: String = String(reflecting: Self.self)

	public static let initial = Self(fill: .initial, radius: 0, border: nil)

	/// Заливка фона
	public let fill: FillStyle

	/// Стиль радиуса
	public let radius: Double

	/// Стиль границ
	public let border: BorderStyle?
	

	// MARK: - Lifecycle

	public init(
		fill: FillStyle,
		radius: Double,
		border: BorderStyle?
	) {
		self.fill = fill
		self.radius = radius
		self.border = border
	}
}
