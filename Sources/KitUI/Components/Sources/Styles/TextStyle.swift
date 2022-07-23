import Foundation
import UIKit

/// Стиль текста
public struct TextStyle: Equatable {

	// MARK: - Static properties

	static let initial = TextStyle(font: .systemFont(ofSize: .initial), lineHeight: .initial)

	// MARK: - Public properties

	/// Шрифт
	public let font: UIFont

	/// Высота линии
	public let lineHeight: Double

	/// Трекинг
	public let tracking: Double
	
	public let strikeThroughStyle: NSUnderlineStyle?

	// MARK: - Lifecycle

	/// Инициализирует структуру
	public init(
		font: UIFont,
		lineHeight: Double,
		tracking: Double = 0,
		strikeThroughStyle: NSUnderlineStyle? = nil
	) {
		self.font = font
		self.lineHeight = lineHeight
		self.tracking = tracking
		self.strikeThroughStyle = strikeThroughStyle
	}

	// MARK: - Internal methods

	/// Возвращает атрибуты от параметров выравнивания и переноса
	/// - Parameters:
	///		- alignment: Выравнивание
	///		- lineBreakMode: Режим переноса
	func attributes(
		for alignment: NSTextAlignment,
		color: UIColor? = nil,
		lineBreakMode: NSLineBreakMode
	) -> [NSAttributedString.Key: Any] {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = alignment
		paragraphStyle.lineBreakMode = lineBreakMode

		var baselineOffset: CGFloat = .zero
		let scaledLineHeight: CGFloat = lineHeight
		paragraphStyle.minimumLineHeight = scaledLineHeight
		paragraphStyle.maximumLineHeight = scaledLineHeight
		baselineOffset = (scaledLineHeight - font.lineHeight) / 4.0
		
		var attributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.kern: tracking,
			NSAttributedString.Key.baselineOffset: baselineOffset,
			NSAttributedString.Key.font: font
		]
		
		if let color = color {
			attributes[NSAttributedString.Key.foregroundColor] = color
		}
		
		if let strikeThroughStyle = strikeThroughStyle {
			attributes[NSAttributedString.Key.strikethroughStyle] = strikeThroughStyle.rawValue
		}

		return attributes
	}
}
