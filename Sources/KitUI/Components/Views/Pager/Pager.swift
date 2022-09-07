import Foundation

public struct Pager: IViewProps, Equatable {
	
	public typealias View = PagerView
	
	public static let type: String = String(reflecting: Self.self)
	
	public static let initial = Pager(
		numberOfPages: 0,
		pageAtIndex: { _ in return .vSpacer },
		currentPage: 0,
		onPageBecameCurrent: .empty,
		onPageScroll: .empty
	)

	public let numberOfPages: Int
	public let pageAtIndex: (Int) -> MetaView
	public let currentPage: Int
	public let onPageBecameCurrent: ViewCommandWith<Int>
	public let onPageScroll: ViewCommandWith<Double>
	
	public static func == (lhs: Pager, rhs: Pager) -> Bool {
		false
	}
}

//public struct PagerChangeID: Equatable {
//	private(set) var id: Int
//	public var type: ChangeType {
//		didSet {
//			if id >= (Int.max - 100) {
//				id = 0
//			} else {
//				id += 1
//			}
//		}
//	}
//
//	public static let initial = Self(id: -1, type: .updateCurrent)
//
//	public enum ChangeType {
//		case updateCurrent
//	}
//
//	public static func == (lhs: Self, rhs: Self) -> Bool {
//		lhs.id == rhs.id
//	}
//}
