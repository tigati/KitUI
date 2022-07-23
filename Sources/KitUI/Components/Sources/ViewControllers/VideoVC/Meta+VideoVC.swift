import Foundation

extension MetaVC {
	public static func videoController(
		url: URL,
		state: VideoVC.State
	) -> MetaVC {
		.init(props: VideoVC(url: url, state: state))
	}
}
