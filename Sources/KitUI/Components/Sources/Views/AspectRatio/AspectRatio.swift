import Foundation
import UIKit

public struct AspectRatio: IViewProps, Equatable {
	
	public typealias View = AspectRatioView
	
	public static let type: String = String(reflecting: Self.self)

	public let content: MetaView
	
	/// width to height
	public let ratio: CGFloat?
	
	public let contentMode: ContentMode
	
	public init(
		content: MetaView,
		ratio: CGFloat?,
		contentMode: ContentMode
	) {
		self.content = content
		self.ratio = ratio
		self.contentMode = contentMode
	}
}
