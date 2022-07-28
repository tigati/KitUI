import Foundation
import UIKit

public extension MetaView {
	func fixedFrame(
		width: Double,
		height: Double
	) -> MetaView {
		.init(
			props: FixedFrame(
				content: self,
				width: width,
				height: height
			)
		)
	}
}
