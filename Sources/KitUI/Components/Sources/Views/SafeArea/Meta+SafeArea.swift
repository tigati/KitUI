import Foundation

public extension MetaView {
	func safeArea(edges: Edge.Set) -> MetaView {
		.init(props: SafeArea(content: self, edges: edges))
	}
}
