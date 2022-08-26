import Foundation
import UIKit

public final class RegularViewController: ViewController & IComponent {
	
	// MARK: Private properties
	
	private var props: RegularVC? = nil
	
	// MARK: - Public properties
	
	public lazy var contentView = RootView()
	
	// MARK: - Override
	
	public override func loadView() {
		view = contentView
	}
	
	public override func viewDidLoad() {
		props?.onViewDidLoad?.perform()
		let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		navigationItem.backBarButtonItem = backBarButton
		super.viewDidLoad()
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = props?.navigationBar == nil
		navigationController?.navigationBar.barStyle = props?.navigationBar?.style.barStyle ?? .default
		
		navigationItem.backBarButtonItem?.tintColor = props?.navigationBar?.style.backButtonTintColor
		
		super.viewWillAppear(animated)
	}
	
	public override func viewDidAppear(_ animated: Bool) {
		props?.onViewDidAppear?.perform()
		super.viewDidAppear(animated)
	}
	
	public override func viewDidDisappear(_ animated: Bool) {
		props?.onViewDidDisappear?.perform()
		super.viewDidDisappear(animated)
	}
	
	public override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	// MARK: - Public methods
	
	public func render(props: RegularVC) {
		defer { self.props = props }
		contentView.render(metaView: props.view)
		
		render(
			oldNavigationBar: self.props?.navigationBar,
			newNavigationBar: props.navigationBar
		)
		
		render(oldProps: self.props?.modalVC, props: props.modalVC)
	}
	
	private func render(oldNavigationBar: NavigationBar?, newNavigationBar: NavigationBar?) {
		if oldNavigationBar == newNavigationBar { return }

		if let newNavigationBar = newNavigationBar {
			navigationController?.isNavigationBarHidden = false
			render(navigationBar: newNavigationBar)
		} else {
			navigationController?.isNavigationBarHidden = true
		}
	}
	
	private func render(navigationBar: NavigationBar) {
		if let leftItems = navigationBar.leftItems {
			let leftBarItems: [UIBarButtonItem] = leftItems.map { metaView in
				let customView = metaView.makeView()
				metaView.update(customView)
				return UIBarButtonItem(customView: customView)
			}
			navigationItem.leftBarButtonItems = leftBarItems
		}
		
		if let rightItems = navigationBar.rightItems {
			let rightBarItems: [UIBarButtonItem] = rightItems.map { metaView in
				let customView = metaView.makeView()
				let barButton = UIBarButtonItem(customView: customView)
				metaView.update(customView)
				return barButton
			}
			navigationItem.rightBarButtonItems = rightBarItems
		}
		
		let titleView = navigationBar.title.makeView()
		navigationBar.title.update(titleView)
		
		navigationItem.titleView = titleView
	}
}

extension RegularViewController: UINavigationBarDelegate {
	public func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
		false
	}
}

extension RegularViewController: UIAdaptivePresentationControllerDelegate {
	public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
		props?.modalVC?.onDismiss?.perform()
	}
}
