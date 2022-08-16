import Foundation

public enum Edge: Int8, CaseIterable, Hashable {

	case top = 1
	
	case bottom = 2
	
	case leading = 3

	case trailing = 4
}

extension Edge {

	public struct Set: OptionSet, Hashable {

		public let rawValue: Int8

		public typealias Element = Edge.Set

		public typealias RawValue = Int8

		public init(rawValue: Int8) {
			self.rawValue = rawValue
		}
		
		public static let top = Self(rawValue: Edge.top.rawValue)
		
		public static let bottom = Self(rawValue: Edge.bottom.rawValue)
		
		public static let leading = Self(rawValue: Edge.leading.rawValue)
		
		public static let trailing = Self(rawValue: Edge.trailing.rawValue)

		public static let vertical: Set = [.top, .bottom]

		public static let horizontal: Set = [.leading, trailing]
		
		public static let all: Set = [.top, .bottom, .leading, .trailing]
	}
}

