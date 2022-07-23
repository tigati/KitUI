import Foundation

extension Int: Sequence {
	public func makeIterator() -> CountableRange<Int>.Iterator {
		return (0..<self).makeIterator()
	}
}
