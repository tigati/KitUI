import Foundation

public extension MetaView {
	static func systemLabel(text: String, style: Label.Style) -> MetaView {
		.init(props: Label(text: text, style: style))
	}
}
