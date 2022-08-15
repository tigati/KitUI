import Foundation
import UIKit

public extension MetaView {
	static func table(
		changeID: ChangeID,
		numberOfSections: Int,
		numberOfRowsInSection: @escaping (Int) -> Int,
		cellAtIndexPath: @escaping (IndexPath) -> MetaView?,
		headerAtSection: ((Int) -> MetaView?)? = nil,
		footerAtSection: ((Int) -> MetaView?)? = nil,
		canMoveCell: ((IndexPath) -> Bool)? = nil,
		proposedIndexPathOnMoveFromTo: ((IndexPath, IndexPath) -> IndexPath)? = nil,
		onReorder: ViewCommandWith<(from: IndexPath, to: IndexPath)>?,
		spacing: CGFloat
	) -> MetaView {
		.init(
			props: Table(
				changeID: changeID,
				numberOfSections: numberOfSections,
				numberOfRowsInSection: numberOfRowsInSection,
				cellAtIndexPath: cellAtIndexPath,
				headerAtSection: headerAtSection,
				footerAtSection: footerAtSection,
				canMoveCell: canMoveCell,
				proposedIndexPathOnMoveFromTo: proposedIndexPathOnMoveFromTo,
				onReorder: onReorder,
				spacing: spacing
			)
		)
	}
}
