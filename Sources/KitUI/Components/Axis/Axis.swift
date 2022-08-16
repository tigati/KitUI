import Foundation

/// Ось
public enum Axis: Int8, CaseIterable, Hashable {

	/// Горизонтальная
	case horizontal = 1

	/// Вертикальная
	case vertical = 2
}

extension Axis {

	public struct Set: OptionSet, Hashable {

		public let rawValue: Int8

		public typealias Element = Axis.Set

		public typealias RawValue = Int8

		public init(rawValue: Int8) {
			self.rawValue = rawValue
		}

		public static let vertical = Self(rawValue: Axis.vertical.rawValue)

		public static let horizontal = Self(rawValue: Axis.horizontal.rawValue)
		
		public static let all: Set = [.vertical, .horizontal]
	}
}
