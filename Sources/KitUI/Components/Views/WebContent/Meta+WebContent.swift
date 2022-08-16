import Foundation

extension MetaView {
	public static func webContent(
		url: URL,
		onFinishLoading: ViewCommand
	) -> MetaView {
		.init(
			props: WebContent(
				url: url,
				onFinishLoading: onFinishLoading
			)
		)
	}
}
