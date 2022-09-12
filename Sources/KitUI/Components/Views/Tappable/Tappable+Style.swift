import UIKit

extension Tappable {

	public struct Style: Equatable {
		
		public static let initial = Style(disabledOpacity: 1, pressedScale: 1)

		// MARK: - Public

		/// Непрозрачность при состоянии `disabled`
		public let disabledOpacity: CGFloat

		/// Как сильно уменьшается компонент
		/// при нажатом состоянии
		public let pressedScale: CGFloat

		// MARK: - Lifecycle

		public init(
			disabledOpacity: CGFloat = 1.0,
			pressedScale: CGFloat = 1.0
		) {
			self.disabledOpacity = disabledOpacity
			self.pressedScale = pressedScale
		}
	}
}
