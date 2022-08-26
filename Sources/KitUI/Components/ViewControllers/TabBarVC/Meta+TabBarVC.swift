import Foundation

public extension MetaVC {
	static func tabBar(
		tabs: [TabBarVC.Tab],
		selectedTabIndex: Int,
		modalVC: ModalVC? = nil,
		style: TabBarVC.Style
	) -> MetaVC {
		.init(
			props: TabBarVC(
				tabs: tabs,
				selectedTabIndex: selectedTabIndex,
				modalVC: modalVC,
				style: style
			)
		)
	}
}
