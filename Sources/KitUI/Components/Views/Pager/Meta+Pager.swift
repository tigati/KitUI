import Foundation

extension MetaView {
	public static func pager(
		numberOfPages: Int,
		pageAtIndex: @escaping (Int) -> MetaView,
		currentPage: Int,
		onPageBecameCurrent: ViewCommandWith<Int>
	) -> MetaView {
		.init(
			props: Pager(
				numberOfPages: numberOfPages,
				pageAtIndex: pageAtIndex,
				currentPage: currentPage,
				onPageBecameCurrent: onPageBecameCurrent
			)
		)
	}
}
