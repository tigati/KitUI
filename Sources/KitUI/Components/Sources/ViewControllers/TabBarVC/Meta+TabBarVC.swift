import Foundation

public extension MetaVC {
	static func tabBar(
		tabs: [TabBarVC.Tab],
		selectedTabIndex: Int,
		style: TabBarVC.Style
	) -> MetaVC {
		.init(
			props: TabBarVC(
				tabs: tabs,
				selectedTabIndex: selectedTabIndex,
				style: style
			)
		)
	}
}
