import Foundation
import UIKit

public struct Separator: IViewProps, Equatable {
	public static let type: String = String(reflecting: Self.self)
	
	public typealias View = SeparatorView
	
	public static let initial = Separator(
		axis: .horizontal,
		color: .initial,
		width: 1
	)
	
	public let axis: Axis
	public let color: UIColor
	public let width: CGFloat
	
	public init(
		axis: Axis,
		color: UIColor,
		width: CGFloat
	) {
		self.axis = axis
		self.color = color
		self.width = width
	}
}
