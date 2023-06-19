import Foundation

public struct Pager: IViewProps, Equatable {
	
	public typealias View = PagerView
	
	public static let type: String = String(reflecting: Self.self)
	
	public static let initial = Pager(
		changeID: .initial(),
		numberOfPages: 0,
		pageAtIndex: { _ in return .vSpacer },
		currentPage: 0,
		onPageBecameCurrent: .empty,
		onPageScroll: .empty
	)

	public let changeID: PagerChangeID
	public let numberOfPages: Int
	public let pageAtIndex: (Int) -> MetaView
	public let currentPage: Int
	public let onPageBecameCurrent: ViewCommandWith<Int>
	public let onPageScroll: ViewCommandWith<Double>
	
	public static func == (lhs: Pager, rhs: Pager) -> Bool {
		false
	}
}

public struct PagerChangeID: Equatable {
	private(set) var id: UUID
	public var type: ChangeType {
		didSet {
			id = UUID()
		}
	}
	
	public static func initial() -> PagerChangeID {
		return PagerChangeID(id: UUID(), type: .reload)
	}
	
	public enum ChangeType {
		case reload
		case updateVisible
	}
	
	public static func == (lhs: PagerChangeID, rhs: PagerChangeID) -> Bool {
		lhs.id == rhs.id
	}
	
	public init(id: UUID, type: ChangeType) {
		self.id = id
		self.type = type
	}
	
	public init(changeID: TableChangeID) {
		self.id = changeID.id
		self.type = {
			switch changeID.type {
			case .update, .updateVisible:
				return .updateVisible
			case .reload, .insertCellsAt:
				return .updateVisible
			}
		}()
	}
}
