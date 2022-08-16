import Foundation
import UIKit

public extension MetaView {
	func aspectRatio(
		ratio: CGFloat? = nil,
		contentMode: ContentMode = .fit
	) -> MetaView {
		.init(
			props: AspectRatio(
				content: self,
				ratio: ratio,
				contentMode: contentMode
			)
		)
	}
}
