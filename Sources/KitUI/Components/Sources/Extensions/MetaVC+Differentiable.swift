import Foundation
import DifferenceKit

extension MetaVC: Differentiable {
	public var differenceIdentifier: String {
		id
	}
	
	public func isContentEqual(to source: MetaVC) -> Bool {
		false
	}
}
