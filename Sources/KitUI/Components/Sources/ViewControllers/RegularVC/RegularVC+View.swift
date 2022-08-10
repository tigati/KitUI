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
		backBarButton.tintColor = .white
		navigationItem.backBarButtonItem = backBarButton
		super.viewDidLoad()
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = props?.navigationBar == nil
		navigationController?.navigationBar.barStyle = .black
		super.viewWillAppear(animated)
	}
	
	public override func viewDidAppear(_ animated: Bool) {
		props?.onViewDidAppear?.perform()
		super.viewDidAppear(animated)
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
				metaView.update(customView)
				return UIBarButtonItem(customView: customView)
			}
			navigationItem.rightBarButtonItems = rightBarItems
		}
		
		let titleView = navigationBar.title.makeView()
		navigationBar.title.update(titleView)
		
		navigationItem.titleView = titleView
	}
	
	// MARK: Modal presentation

	private func render(oldProps: ModalVC?, props: ModalVC?) {
		switch (oldProps, props) {
		case let (.none, .some(modalVC)):
			presentModalVC(modalVC)
		case let (.some(oldModalVC), .none):
			dismissModalVC(oldModalVC)
		case let (.some(oldModalVC), .some(modalVC)):
			updateModalVC(oldModalVC: oldModalVC, modalVC: modalVC)
		case (.none, .none):
			return
		}
	}

	private func presentModalVC(_ modalVC: ModalVC) {
		let modalViewController = modalVC.viewController.makeView()
		modalViewController.modalPresentationStyle = modalVC.modalPresentationStyle
		modalVC.viewController.update(modalViewController)
		if #available(iOS 13, *) {
			modalViewController.isModalInPresentation = true
		}
		present(modalViewController, animated: true) {
			modalVC.onPresent?.perform()
		}
	}

	private func dismissModalVC(
		_ oldModalVC: ModalVC,
		completion: (() -> Void)? = nil
	) {
		dismiss(animated: true) {
			oldModalVC.onDismiss?.perform()
			completion?()
		}
	}

	private func updateModalVC(oldModalVC: ModalVC, modalVC: ModalVC) {
		// Если id изменился прячем старый экран и показываем новый
		// иначе обновляем видимый
		if oldModalVC.id != modalVC.id {
			dismissModalVC(oldModalVC) {
				self.presentModalVC(modalVC)
			}
		} else {
			guard let modalViewController = presentedViewController else {
				return
			}
			modalVC.viewController.update(modalViewController)
		}
	}
}

extension RegularViewController: UINavigationBarDelegate {
	public func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
		false
	}
}
