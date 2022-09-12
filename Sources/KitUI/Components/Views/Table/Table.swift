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
		changeID: .initial(),
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
		isEditing: false,
		spacing: 0,
		separator: .none,
		bounces: true
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
	let isEditing: Bool
	let spacing: CGFloat
	let separator: UITableViewCell.SeparatorStyle
	let bounces: Bool
	
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
		isEditing: Bool,
		spacing: CGFloat,
		separator: UITableViewCell.SeparatorStyle,
		bounces: Bool
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
		self.isEditing = isEditing
		self.spacing = spacing
		self.separator = separator
		self.bounces = bounces
	}
	
	public static func == (lhs: Table, rhs: Table) -> Bool {
		return lhs.changeID == rhs.changeID
	}
}

public struct TableChangeID: Equatable {
	private(set) var id: UUID
	public var type: ChangeType {
		didSet {
			id = UUID()
		}
	}
	
	public static func initial() -> TableChangeID {
		return TableChangeID(id: UUID(), type: .reload)
	}
	
	public enum ChangeType {
		case reload
		case update([IndexPath])
		case updateVisible
	}
	
	public static func == (lhs: TableChangeID, rhs: TableChangeID) -> Bool {
		lhs.id == rhs.id
	}
}
