import Foundation
import UIKit

public extension MetaView {
	static func pageControl(
		numberOfPages: Int,
		progress: Double,
		activeColor: UIColor,
		inactiveColor: UIColor
	) -> MetaView {
		.init(
			props: PageControl(
				numberOfPages: numberOfPages,
				currentPage: progress,
				isMomentary: true,
				activeColor: activeColor,
				inactiveColor: inactiveColor
			)
		)
	}
	
	static func pageControl(
		numberOfPages: Int,
		currentPage: Int,
		activeColor: UIColor,
		inactiveColor: UIColor
	) -> MetaView {
		.init(
			props: PageControl(
				numberOfPages: numberOfPages,
				currentPage: Double(currentPage),
				isMomentary: false,
				activeColor: activeColor,
				inactiveColor: inactiveColor
			)
		)
	}
}
