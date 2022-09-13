import UIKit

extension AttributedLabel {

	public struct Style: Equatable {

		public static let initial = Style(
			text: .initial,
			color: .initial,
			textAlignment: .left,
			numberOfLines: 1,
			adjustsFontSizeToFitWidth: false
		)

		/// Стиль текста
		public let text: TextStyle

		/// Цвет текста
		public fileprivate(set) var fill: FillStyle

		/// Выравнивание
		public fileprivate(set) var textAlignment: NSTextAlignment

		/// Количество строк
		public fileprivate(set) var numberOfLines: Int
		
		public let adjustsFontSizeToFitWidth: Bool

		// MARK: - Lifecycle
		
		public init(
			text: TextStyle,
			fill: FillStyle,
			textAlignment: NSTextAlignment,
			numberOfLines: Int,
			adjustsFontSizeToFitWidth: Bool = false
		) {
			self.text = text
			self.fill = fill
			self.textAlignment = textAlignment
			self.numberOfLines = numberOfLines
			self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
		}

		public init(
			text: TextStyle,
			color: UIColor,
			textAlignment: NSTextAlignment,
			numberOfLines: Int,
			adjustsFontSizeToFitWidth: Bool = false
		) {
			self.text = text
			self.fill = .solid(color)
			self.textAlignment = textAlignment
			self.numberOfLines = numberOfLines
			self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
		}
		
		public init(
			text: TextStyle,
			gradient: GradientStyle,
			textAlignment: NSTextAlignment,
			numberOfLines: Int,
			adjustsFontSizeToFitWidth: Bool = false
		) {
			self.text = text
			self.fill = .gradient(gradient)
			self.textAlignment = textAlignment
			self.numberOfLines = numberOfLines
			self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
		}
	}
}

extension AttributedLabel.Style {
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
		new.fill = .solid(value)
		return new
	}
}
