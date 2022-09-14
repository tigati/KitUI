import Foundation

extension MetaView {
	public static func pager(
		changeID: PagerChangeID,
		numberOfPages: Int,
		pageAtIndex: @escaping (Int) -> MetaView,
		currentPage: Int,
		onPageBecameCurrent: ViewCommandWith<Int>,
		onPageScroll: ViewCommandWith<Double>
	) -> MetaView {
		.init(
			props: Pager(
				changeID: changeID,
				numberOfPages: numberOfPages,
				pageAtIndex: pageAtIndex,
				currentPage: currentPage,
				onPageBecameCurrent: onPageBecameCurrent,
				onPageScroll: onPageScroll
			)
		)
	}
}
