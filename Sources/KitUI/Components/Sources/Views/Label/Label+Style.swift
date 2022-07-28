import UIKit

extension Label {

	public struct Style: Equatable {

		public static let initial = Style(
			text: .initial,
			color: .initial,
			textAlignment: .left,
			numberOfLines: 1
		)

		/// Стиль текста
		let text: TextStyle

		/// Цвет текста
		let fill: FillStyle

		/// Выравнивание
		let textAlignment: NSTextAlignment

		/// Количество строк
		let numberOfLines: Int

		// MARK: - Lifecycle

		public init(
			text: TextStyle,
			color: UIColor,
			textAlignment: NSTextAlignment,
			numberOfLines: Int
		) {
			self.text = text
			self.fill = .solid(color)
			self.textAlignment = textAlignment
			self.numberOfLines = numberOfLines
		}
		
		public init(
			text: TextStyle,
			gradient: GradientStyle,
			textAlignment: NSTextAlignment,
			numberOfLines: Int
		) {
			self.text = text
			self.fill = .gradient(gradient)
			self.textAlignment = textAlignment
			self.numberOfLines = numberOfLines
		}
	}
}