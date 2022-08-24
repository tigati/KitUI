import Foundation

public struct Image: IViewProps, Equatable {
	
	public static let initial = Image(style: .initial)
	
	public static let type: String = String(reflecting: Self.self)
	
	public typealias View = ImageView

	let id: String?
	let resource: ImageResource?
	let style: Style

	// MARK: - Lifecycle

	public init(
		id: String? = nil,
		resource: ImageResource? = nil,
		style: Style
	) {
		self.id = id
		self.resource = resource
		self.style = style
	}
}
