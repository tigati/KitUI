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

	// MARK: - Public methods

	public func render(props: Label) {
		text = props.text
		style = props.style
		font = props.style.font
		textAlignment = props.style.textAlignment
		numberOfLines = props.style.numberOfLines
		adjustsFontSizeToFitWidth = props.style.adjustsFontSizeToFitWidth
	}
}
