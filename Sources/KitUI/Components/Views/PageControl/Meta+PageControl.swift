import Foundation

public extension MetaView {
	static func pageControl(
		numberOfPages: Int,
		progress: Double
	) -> MetaView {
		.init(
			props: PageControl(
				numberOfPages: numberOfPages,
				currentPage: progress,
				isMomentary: true
			)
		)
	}
	
	static func pageControl(
		numberOfPages: Int,
		currentPage: Int
	) -> MetaView {
		.init(
			props: PageControl(
				numberOfPages: numberOfPages,
				currentPage: Double(currentPage),
				isMomentary: false
			)
		)
	}
}
