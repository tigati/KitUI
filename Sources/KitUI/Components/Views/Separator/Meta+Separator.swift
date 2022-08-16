import Foundation
import UIKit

extension MetaView {
	public static func hSeparator(color: UIColor, width: CGFloat = 1) -> MetaView {
		.init(
			props: Separator(
				axis: .horizontal,
				color: color,
				width: width
			)
		)
	}
	
	public static func vSeparator(color: UIColor, width: CGFloat = 1) -> MetaView {
		.init(
			props: Separator(
				axis: .vertical,
				color: color,
				width: width
			)
		)
	}
}
