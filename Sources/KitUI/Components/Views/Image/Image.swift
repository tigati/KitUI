import Foundation

public struct Image: IViewProps, Equatable {
	
	public static let initial = Image(style: .initial)
	
	public static let type: String = String(reflecting: Self.self)
	
	public typealias View = ImageView

	let resource: ImageResource?
	let style: Style

	// MARK: - Lifecycle

	public init(
		resource: ImageResource? = nil,
		style: Style
	) {
		self.resource = resource
		self.style = style
	}
}
