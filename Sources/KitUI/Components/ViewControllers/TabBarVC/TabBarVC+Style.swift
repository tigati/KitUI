import Foundation
import UIKit

extension TabBarVC {

	public struct Style: Equatable {

		// MARK: - Static

		static let initial = Style(
			tabBarColor: .initial,
			selectedColor: .initial,
			unselectedColor: .initial
		)

		// MARK: - Public

		/// Цвет подложки
		public let tabBarColor: UIColor

		/// Цвет текста и иконки выделенного таба
		public let selectedColor: UIColor

		/// Цвет текста и иконки не выделенного таба
		public let unselectedColor: UIColor

		// MARK: - Lifecycle

		public init(
			tabBarColor: UIColor,
			selectedColor: UIColor,
			unselectedColor: UIColor
		) {
			self.tabBarColor = tabBarColor
			self.selectedColor = selectedColor
			self.unselectedColor = unselectedColor
		}
	}
}
