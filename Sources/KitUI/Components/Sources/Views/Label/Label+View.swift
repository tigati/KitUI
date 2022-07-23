import Foundation
import UIKit

/// Лейбл с возможностью установки текста с настройками lineHeight и letter-spacing
public class LabelView: UILabel, IComponent {

	// MARK: - Private properties

	private var style: Label.Style?

	// MARK: - Lifecycle

	public init() {
		super.init(frame: .zero)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Overrides
	
	public override func drawText(in rect: CGRect) {
		if
			case let .gradient(gradient) = style?.fill,
			let gradientColor = drawGradient(
				gradient: gradient, in: rect
			)
		{
			self.textColor = gradientColor
		}
		
		if case let .solid(color) = style?.fill {
			self.textColor = color
		}

		super.drawText(in: rect)
	}

	public override var text: String? {
		get {
			guard style?.text.attributes != nil else {
				return super.text
			}

			return attributedText?.string
		}
		set {
			guard let style = style else {
				super.text = newValue
				return
			}

			guard let newText = newValue else {
				attributedText = nil
				super.text = nil
				return
			}

			let attributes = style.text.attributes(for: textAlignment, lineBreakMode: lineBreakMode)
			attributedText = NSAttributedString(string: newText, attributes: attributes)
		}
	}

	// MARK: - Public methods

	public func render(props: Label) {
		text = nil
		text = props.text
		style = props.style
		textAlignment = props.style.textAlignment
		numberOfLines = props.style.numberOfLines
		updateText()
	}

	// MARK: - Private methods

	private func updateText() {
		text = super.text
	}
	
	private func drawGradient(gradient: GradientStyle, in rect: CGRect) -> UIColor? {
		let currentContext = UIGraphicsGetCurrentContext()
		currentContext?.saveGState()
		defer { currentContext?.restoreGState() }
		
		let size = rect.size
		UIGraphicsBeginImageContextWithOptions(size, false, 0)
		guard let cgGradient = CGGradient(
			colorsSpace: CGColorSpaceCreateDeviceRGB(),
			colors: gradient.colors.map { $0.cgColor } as CFArray,
			locations: UnsafePointer<CGFloat>(gradient.locations.map { CGFloat($0) })
		)
		else { return nil }
		
		let context = UIGraphicsGetCurrentContext()
		context?.drawLinearGradient(
			cgGradient,
			start: CGPoint(
				x: gradient.startPoint.x * size.width,
				y: gradient.startPoint.y * size.height
			),
			end: CGPoint(
				x: gradient.endPoint.x * size.width,
				y: gradient.endPoint.y * size.height
			),
			options: []
		)
		let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		guard let image = gradientImage else { return nil }
		return UIColor(patternImage: image)
	}
}
