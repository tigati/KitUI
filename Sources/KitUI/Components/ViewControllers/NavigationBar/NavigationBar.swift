import Foundation

public struct NavigationBar: Equatable {
	public let leftItems: [BarItem]?
	public let title: MetaView
	public let rightItems: [BarItem]?
	public let style: Style
	
	public init(
		leftItems: [BarItem]? = nil,
		title: MetaView,
		rightItems: [BarItem]? = nil,
		style: Style
	)
	{
		self.leftItems = leftItems
		self.title = title
		self.rightItems = rightItems
		self.style = style
	}
}
