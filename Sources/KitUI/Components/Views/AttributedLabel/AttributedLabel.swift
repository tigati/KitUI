import Foundation

public struct AttributedLabel: IViewProps, Equatable {
	
	// MARK: - Typealiases
	
	public typealias View = AttributedLabelView
	
	// MARK: - Static
	
	public static let type: String = String(reflecting: Self.self)
	
	// MARK: - Public properties
	
	public let text: String
	public var style: Style
	
	// MARK: - Lifecylce
	
	public init(text: String, style: Style) {
		self.text = text
		self.style = style
	}
}
