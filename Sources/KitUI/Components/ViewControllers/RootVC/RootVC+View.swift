import Foundation
import UIKit

public final class RootViewController: ViewController, IComponent {

	private var props: RootVC?

	private var childViewController: UIViewController?

	private var blurView: UIVisualEffectView?
	private var snackBarView: UIView?

	private var loadingView: UIView?

	public func render(props: RootVC) {
		defer { self.props = props }

		if props.childVC.type != self.props?.childVC.type {
			removeChildVC()
			addChildVC(props.childVC)
			view.setNeedsLayout()
		}

		if let childViewController = childViewController {
			props.childVC.update(childViewController)
		}

		if props.snackBar != self.props?.snackBar {
			render(oldSnackBar: self.props?.snackBar, newSnackBar: props.snackBar)
		}

		if props.loadingView != self.props?.loadingView {
			render(oldLoadingView: self.props?.loadingView, newLoadingView: props.loadingView)
		}
	}
	
	private func removeChildVC() {
		childViewController?.dismiss(animated: false)
		childViewController?.willMove(toParent: nil)
		childViewController?.removeFromParent()
		childViewController?.view.removeFromSuperview()
	}

	private func addChildVC(_ childVC: MetaVC) {
		let childViewController = childVC.makeView()
		view.addSubview(childViewController.view)
		addChild(childViewController)
		childViewController.didMove(toParent: self)
		self.childViewController = childViewController
	}

	private func render(oldSnackBar: MetaView?, newSnackBar: MetaView?) {
		switch (oldSnackBar, newSnackBar) {
		case (.none, .some(let props)):
			
			let blurEffect = UIBlurEffect(style: .regular)
			let newBlurView = UIVisualEffectView(effect: blurEffect)
			blurView = newBlurView
			view.addSubview(newBlurView)
			
			let newSnackBar = props.viewType.init()
			props.update(newSnackBar)
			view.addSubview(newSnackBar)
			snackBarView = newSnackBar
		case (.some, .none):
			blurView?.removeFromSuperview()
			blurView = nil
			
			snackBarView?.removeFromSuperview()
			snackBarView = nil
		case (.some, .some(let props)):
			if let snackBarView = snackBarView {
				props.update(snackBarView)
			}
		case (.none, .none):
			return
		}

		view.setNeedsLayout()
	}

	private func render(oldLoadingView: MetaView?, newLoadingView: MetaView?) {
		switch (oldLoadingView, newLoadingView) {
		case (.none, .some(let props)):
			let newLoadingView = props.viewType.init()
			props.update(newLoadingView)
			view.addSubview(newLoadingView)
			loadingView = newLoadingView
		case (.some, .none):
			loadingView?.removeFromSuperview()
			loadingView = nil
		case (.some, .some(let props)):
			if let loadingView = loadingView {
				props.update(loadingView)
			}
		case (.none, .none):
			return
		}

		view.setNeedsLayout()
	}

	override public func viewDidLayoutSubviews() {
		childViewController?.view.pin.all()
		
		loadingView?.pin.all()
		
		blurView?.pin.all()

		snackBarView?.pin.horizontally(52.5).vCenter()
			.sizeToFit(.width)
	}
}
