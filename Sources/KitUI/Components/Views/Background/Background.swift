import Foundation

public struct Background: IViewProps, Equatable {

	public typealias View = BackgroundView
	
	public static let type: String = String(reflecting: Self.self)
	
	public let content: MetaView
	
	public let background: MetaView
}
