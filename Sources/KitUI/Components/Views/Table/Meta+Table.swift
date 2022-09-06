import Foundation
import UIKit

public extension MetaView {
	static func table(
		changeID: TableChangeID,
		numberOfSections: Int,
		numberOfRowsInSection: @escaping (Int) -> Int,
		cellAtIndexPath: @escaping (IndexPath) -> MetaView?,
		headerAtSection: ((Int) -> MetaView?)? = nil,
		footerAtSection: ((Int) -> MetaView?)? = nil,
		canMoveCell: ((IndexPath) -> Bool)? = nil,
		proposedIndexPathOnMoveFromTo: ((IndexPath, IndexPath) -> IndexPath)? = nil,
		onReorder: ViewCommandWith<(from: IndexPath, to: IndexPath)>? = nil,
		spacing: CGFloat = 0,
		separator: UITableViewCell.SeparatorStyle = .none
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
				spacing: spacing,
				separator: separator
			)
		)
	}
}
