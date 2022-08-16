import Foundation

public struct NavigationBar: Equatable {
	public let leftItems: [MetaView]?
	public let title: MetaView
	public let rightItems: [MetaView]?
	public let style: Style
	
	public init(
		leftItems: [MetaView]? = nil,
		title: MetaView,
		rightItems: [MetaView]? = nil,
		style: Style
	)
	{
		self.leftItems = leftItems
		self.title = title
		self.rightItems = rightItems
		self.style = style
	}
}
