import Foundation

public struct NavigationBar: Equatable {
	public let leftItems: [MetaView]?
	public let title: MetaView
	public let rightItems: [MetaView]?
	
	public init(
		leftItems: [MetaView]?,
		title: MetaView,
		rightItems: [MetaView]?)
	{
		self.leftItems = leftItems
		self.title = title
		self.rightItems = rightItems
	}
}
