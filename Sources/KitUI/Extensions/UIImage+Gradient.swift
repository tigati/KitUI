import Foundation
import UIKit

extension UIImageView {
	func applyGradient(_ gradient: GradientStyle) {
		let rect = bounds
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = rect
		gradientLayer.colors = gradient.colors.map { $0.cgColor }
		gradientLayer.locations = gradient.locations.map { NSNumber(value: $0) }
		gradientLayer.startPoint = gradient.startPoint
		gradientLayer.endPoint = gradient.endPoint
		
		let mask = CALayer()
		mask.frame = rect
		mask.contents = image?.cgImage
		gradientLayer.mask = mask
		UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
		gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
		let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		image = gradientImage
	}
}
