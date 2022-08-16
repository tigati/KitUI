import Foundation
import AVKit

public class VideoVC: NSObject, IViewProps {
	public init(url: URL, state: VideoVC.State) {
		self.url = url
		self.state = state
	}
	
	public func makeView(viewType: AVPlayerViewController.Type) -> AVPlayerViewController {
		let player = AVPlayer(url: url)
		let viewController = AVPlayerViewController()
		viewController.player = player
		viewController.delegate = self
		return viewController
	}
	
	public func updateView(_ view: AVPlayerViewController) {
	}
	
	
	// MARK: - Static

	public static let type: String = "KitUI.VideoVC"
	
	public typealias View = AVPlayerViewController
	
	let url: URL
	
	let state: State
	
	let onDismiss: ViewCommand? = nil
	
	public enum State {
		case playing
		case paused
	}
}

extension VideoVC: AVPlayerViewControllerDelegate {
	func playerViewControllerDidEndDismissalTransition() {
		
	}
}
