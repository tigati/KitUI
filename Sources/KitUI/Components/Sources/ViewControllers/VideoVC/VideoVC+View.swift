import Foundation
import AVKit

extension AVPlayerViewController: IComponent {
	public func render(props: VideoVC) {
		switch props.state {
		case .paused:
			player?.pause()
		case .playing:
			player?.play()
		}
	}
	
	@objc open override func setViewID(_ viewID: String) {
		
	}
	@objc open override func getViewID() -> String {
		return "VideoVC"
	}
}
