import Foundation

public struct KeyboardAware: IViewProps, Equatable {

	public typealias View = KeyboardAwareView
	
	public static let type: String = String(reflecting: Self.self)
	
	public let content: MetaView
}
