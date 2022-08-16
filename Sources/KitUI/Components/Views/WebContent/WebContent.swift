import Foundation
import UIKit

public struct WebContent: IViewProps, Equatable {
	public typealias View = WebContentView
	
	public static let type: String = String(reflecting: Self.self)
	
	public let url: URL
	
	public let onFinishLoading: ViewCommand
}
