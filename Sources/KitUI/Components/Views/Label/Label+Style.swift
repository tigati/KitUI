import UIKit

extension Label {

	public struct Style: Equatable {

		public static let initial = Style(
			font: .systemFont(ofSize: 16),
			color: .initial,
			textAlignment: .left,
			numberOfLines: 1,
			adjustsFontSizeToFitWidth: false
		)

		/// Стиль текста
		public let font: UIFont

		/// Цвет текста
		public fileprivate(set) var color: UIColor

		/// Выравнивание
		public fileprivate(set) var textAlignment: NSTextAlignment

		/// Количество строк
		public fileprivate(set) var numberOfLines: Int
		
		public let adjustsFontSizeToFitWidth: Bool

		// MARK: - Lifecycle
		
		public init(
			font: UIFont,
			color: UIColor,
			textAlignment: NSTextAlignment,
			numberOfLines: Int,
			adjustsFontSizeToFitWidth: Bool = false
		) {
			self.font = font
			self.color = color
			self.textAlignment = textAlignment
			self.numberOfLines = numberOfLines
			self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
		}

	}
}

extension Label.Style {
	public func numberOfLines(_ value: Int) -> Self {
		var new = self
		new.numberOfLines = value
		return new
	}
	
	public func textAlignment(_ value: NSTextAlignment) -> Self {
		var new = self
		new.textAlignment = value
		return new
	}
	
	public func color(_ value: UIColor) -> Self {
		var new = self
		new.color = value
		return new
	}
}
