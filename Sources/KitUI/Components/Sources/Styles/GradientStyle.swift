import Foundation
import UIKit

public struct GradientStyle: Equatable {
	
	let colors: [UIColor]
	let locations: [Double]
	let startPoint: CGPoint
	let endPoint: CGPoint
	
	public init(
		colors: [UIColor],
		locations: [Double],
		startPoint: CGPoint,
		endPoint: CGPoint
	) {
		self.colors = colors
		self.locations = locations
		self.startPoint = startPoint
		self.endPoint = endPoint
	}
}
