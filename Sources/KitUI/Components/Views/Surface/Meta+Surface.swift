import Foundation
import UIKit

extension MetaView {
	public static func surface(
		fill: FillStyle,
		radius: Double = 0,
		border: BorderStyle? = nil
	) -> MetaView {
		.init(
			props: Surface(
				fill: fill,
				radius: radius,
				border: border
			)
		)
	}
	
	public static func surface(
		gradient: GradientStyle,
		radius: Double = 0,
		border: BorderStyle? = nil
	) -> MetaView {
		surface(
			fill: .gradient(gradient),
			radius: radius,
			border: border
		)
	}
	
	public static func surface(
		color: UIColor,
		radius: Double = 0,
		border: BorderStyle? = nil
	) -> MetaView {
		surface(
			fill: .solid(color),
			radius: radius,
			border: border
		)
	}
}
