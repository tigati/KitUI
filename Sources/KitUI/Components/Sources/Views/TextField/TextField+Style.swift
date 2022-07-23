import UIKit

extension TextField {

	public struct Style: Equatable {
		// MARK: - Public properties

		public static let initial = Style(
			text: .initial,
			textColor: .initial,
			placeholder: .initial,
			placeholderColor: .initial,
			cursorColor: .initial,
			textAlignment: .left
		)

		public let text: TextStyle
		public let textColor: UIColor
		public let placeholder: TextStyle
		public let placeholderColor: UIColor
		public let cursorColor: UIColor
		public let textAlignment: NSTextAlignment

		// MARK: - Lifecycle
		
		public init(
			text: TextStyle,
			textColor: UIColor,
			placeholder: TextStyle,
			placeholderColor: UIColor,
			cursorColor: UIColor,
			textAlignment: NSTextAlignment
		) {
			self.text = text
			self.textColor = textColor
			self.placeholder = placeholder
			self.placeholderColor = placeholderColor
			self.cursorColor = cursorColor
			self.textAlignment = textAlignment
		}
	}
}
