import Foundation

extension FloatingPoint {
		var isWhole: Bool {
				return floor(self) == self
		}
}
