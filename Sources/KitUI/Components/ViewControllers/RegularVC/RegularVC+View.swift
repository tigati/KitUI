import Foundation
import UIKit

public final class RegularViewController: ViewController & IComponent {
	
	// MARK: Private properties
	
	private var props: RegularVC? = nil
	
	// MARK: - Public properties
	
	public lazy var contentView = RootView()
	
	public var titleViewID: String?
	
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
		renderLeftItems(
			oldItems: oldNavigationBar?.leftItems,
			newItems: newNavigationBar?.leftItems
		)
		
		renderTitleView(newNavigationBar?.title)
		
		renderRightItems(
			oldItems: oldNavigationBar?.rightItems,
			newItems: newNavigationBar?.rightItems
		)

		if let newNavigationBar = newNavigationBar {
			navigationController?.isNavigationBarHidden = false
		} else {
			navigationController?.isNavigationBarHidden = true
		}
		
		
	}
	
	private func renderTitleView(_ title: MetaView?) {
		guard let title = title else {
			navigationItem.titleView = nil
			return
		}
		
		if titleViewID != title.id {
			let titleView = title.makeView()
			navigationItem.titleView = titleView
			titleViewID = title.id
		}
		
		if let titleView = navigationItem.titleView {
			title.update(titleView)
		}
	}
	
	private func renderLeftItems(oldItems: [BarItem]?, newItems: [BarItem]?) {
		
		guard newItems != oldItems else {
			return
		}
		
		let barItems: [UIBarButtonItem]? = newItems?.enumerated().map { index, item in
			let barItem = item.map()
			barItem.tag = index
			barItem.target = self
			barItem.action = #selector(leftItemTapped)
			return barItem
		}
		
		navigationItem.leftBarButtonItems = barItems
	}
	
	private func renderRightItems(oldItems: [BarItem]?, newItems: [BarItem]?) {
		
		guard newItems != oldItems else {
			return
		}
		
		let barItems: [UIBarButtonItem]? = newItems?.enumerated().map { index, item in
			let barItem = item.map()
			barItem.tag = index
			barItem.target = self
			barItem.action = #selector(rightItemTapped)
			return barItem
		}
		
		navigationItem.rightBarButtonItems = barItems
	}
	
	@objc
	private func leftItemTapped(_ item: UIBarButtonItem) {
		props?.navigationBar?.leftItems?[item.tag].onTap?.perform()
	}
	
	@objc
	private func rightItemTapped(_ item: UIBarButtonItem) {
		props?.navigationBar?.rightItems?[item.tag].onTap?.perform()
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
	
	public func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
		props?.modalVC?.onAttemptToDismiss?.perform()
	}
}
