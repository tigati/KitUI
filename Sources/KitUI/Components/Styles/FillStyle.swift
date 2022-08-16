import Foundation
import UIKit

public enum FillStyle: Equatable {
	
	static let initial: FillStyle = .solid(.initial)
	
	case solid(UIColor)
	case gradient(GradientStyle)
}
