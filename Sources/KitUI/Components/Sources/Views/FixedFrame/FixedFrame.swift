import Foundation

public struct FixedFrame: IViewProps, Equatable {
	
	public typealias View = FixedFrameView
	
	public static let type: String = String(reflecting: Self.self)
	
	public let content: MetaView
	public let width: Double?
	public let height: Double?
	
	public init(
		content: MetaView,
		width: Double?,
		height: Double?
	) {
		self.content = content
		self.width = width
		self.height = height
	}
}
