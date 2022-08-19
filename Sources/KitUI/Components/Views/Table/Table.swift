//
//  Table.swift
//  DrivenUI
//
//  Created by Gayfulin Timur Farkhatovich on 15.11.2021.
//

import Foundation
import UIKit

/// Пропсы для Table
/// Внутри использует `UITableView`
public struct Table: IViewProps, Equatable {
	public typealias View = TableView

	// MARK: - Static

	public static let type: String = String(reflecting: Self.self)
	
	public static let initial = Table(
		changeID: .initial,
		numberOfSections: 0,
		numberOfRowsInSection: { _ in
			return 0
		},
		cellAtIndexPath: { _ in
			return nil
		},
		headerAtSection: nil,
		footerAtSection: nil,
		canMoveCell: nil,
		proposedIndexPathOnMoveFromTo: nil,
		onReorder: nil,
		spacing: 0
	)

	// MARK: - Internal properties

	let changeID: TableChangeID
	let numberOfSections: Int
	let numberOfRowsInSection: (Int) -> Int
	let cellAtIndexPath: (IndexPath) -> MetaView?
	let headerAtSection: ((Int) -> MetaView?)?
	let footerAtSection: ((Int) -> MetaView?)?
	let canMoveCell: ((IndexPath) -> Bool)?
	let proposedIndexPathOnMoveFromTo: ((_ from: IndexPath, _ to: IndexPath) -> IndexPath)?
	let onReorder: ViewCommandWith<(from: IndexPath, to: IndexPath)>?
	let spacing: CGFloat
	
	public init(
		changeID: TableChangeID,
		numberOfSections: Int,
		numberOfRowsInSection: @escaping (Int) -> Int,
		cellAtIndexPath: @escaping (IndexPath) -> MetaView?,
		headerAtSection: ((Int) -> MetaView?)?,
		footerAtSection: ((Int) -> MetaView?)?,
		canMoveCell: ((IndexPath) -> Bool)?,
		proposedIndexPathOnMoveFromTo: ((_ from: IndexPath, _ to: IndexPath) -> IndexPath)?,
		onReorder: ViewCommandWith<(from: IndexPath, to: IndexPath)>?,
		spacing: CGFloat
	) {
		self.changeID = changeID
		self.numberOfSections = numberOfSections
		self.numberOfRowsInSection = numberOfRowsInSection
		self.cellAtIndexPath = cellAtIndexPath
		self.headerAtSection = headerAtSection
		self.footerAtSection = footerAtSection
		self.canMoveCell = canMoveCell
		self.proposedIndexPathOnMoveFromTo = proposedIndexPathOnMoveFromTo
		self.onReorder = onReorder
		self.spacing = spacing
	}
	
	public static func == (lhs: Table, rhs: Table) -> Bool {
		return lhs.changeID == rhs.changeID
	}
}

public struct TableChangeID: Equatable {
	private(set) var id: Int
	public var type: ChangeType {
		didSet {
			if id >= (Int.max - 100) {
				id = 0
			} else {
				id += 1
			}
		}
	}
	
	public static let initial = TableChangeID(id: -1, type: .reload)
	
	public enum ChangeType {
		case reload
		case update([IndexPath])
		case updateVisible
	}
	
	public static func == (lhs: TableChangeID, rhs: TableChangeID) -> Bool {
		lhs.id == rhs.id
	}
}

/// Секция с ячейками
/// Используется в декларативном синтаксисе
public struct TableSection {
	let header: MetaView?
	let cells: [MetaView]
	let footer: MetaView?

	/// Создание секции с `variardic` ячейками
	public static func section(
		header: MetaView? = nil,
		_ cells: MetaView...,
		footer: MetaView? = nil
	) -> TableSection {
		.init(
			header: header,
			cells: cells,
			footer: footer
		)
	}

	/// Создание секции с массивом ячеек
	public static func section(
		header: MetaView? = nil,
		_ cells: [MetaView],
		footer: MetaView? = nil
	) -> TableSection {
		.init(
			header: header,
			cells: cells,
			footer: footer
		)
	}
}
