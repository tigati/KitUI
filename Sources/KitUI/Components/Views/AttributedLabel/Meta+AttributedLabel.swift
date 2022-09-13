import Foundation

public extension MetaView {
	static func label(text: String, style: AttributedLabel.Style) -> MetaView {
		.init(props: AttributedLabel(text: text, style: style))
	}
}
