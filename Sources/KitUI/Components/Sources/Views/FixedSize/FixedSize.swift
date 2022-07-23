import Foundation

public struct FixedSize: IViewProps, Equatable {
	
	public typealias View = FixedSizeView
	
	public static let type: String = String(reflecting: Self.self)
	
	public let horizontal: Bool
	public let vertical: Bool
	public let content: MetaView
	
	public init(horizontal: Bool, vertical: Bool, content: MetaView) {
		self.horizontal = horizontal
		self.vertical = vertical
		self.content = content
	}
}
