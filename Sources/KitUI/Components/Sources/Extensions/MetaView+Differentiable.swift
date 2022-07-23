import Foundation
import DifferenceKit

extension MetaView: Differentiable {
	public var differenceIdentifier: String {
		id ?? type
	}
	
	public func isContentEqual(to source: MetaView) -> Bool {
		self == source
	}
}


