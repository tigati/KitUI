import Foundation
import UIKit

extension NavigationBar {
	public struct Style: Equatable {
		public let barStyle: UIBarStyle
		public let backButtonTintColor: UIColor
		
		public init(
			barStyle: UIBarStyle,
			backButtonTintColor: UIColor
		) {
			self.barStyle = barStyle
			self.backButtonTintColor = backButtonTintColor
		}
	}
}
