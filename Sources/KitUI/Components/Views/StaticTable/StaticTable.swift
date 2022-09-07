import Foundation
import UIKit

public struct StaticTable {
	
	static let initial = Self(
		sections: [],
		canMoveCell: nil,
		proposedIndexPathOnMoveFromTo: nil,
		onReorder: nil,
		spacing: 0,
		separator: .none
	)
	
	let sections: [TableSection]
	let canMoveCell: ((IndexPath) -> Bool)?
	let proposedIndexPathOnMoveFromTo: ((_ from: IndexPath, _ to: IndexPath) -> IndexPath)?
	let onReorder: ViewCommandWith<(from: IndexPath, to: IndexPath)>?
	let spacing: CGFloat
	let separator: UITableViewCell.SeparatorStyle
}

/// Секция с ячейками
/// Используется в декларативном синтаксисе
public struct TableSection: Equatable {
//	let header: MetaView?
	let cells: [MetaView]
//	let footer: MetaView?

	/// Создание секции с `variardic` ячейками
	public static func section(
		header: MetaView? = nil,
		_ cells: MetaView...,
		footer: MetaView? = nil
	) -> TableSection {
		.init(
//			header: header,
			cells: cells
//			footer: footer
		)
	}

	/// Создание секции с массивом ячеек
	public static func section(
		header: MetaView? = nil,
		_ cells: [MetaView],
		footer: MetaView? = nil
	) -> TableSection {
		.init(
//			header: header,
			cells: cells
//			footer: footer
		)
	}
}
