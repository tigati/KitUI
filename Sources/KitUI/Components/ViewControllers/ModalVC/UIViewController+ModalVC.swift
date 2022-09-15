import Foundation
import UIKit

extension UIAdaptivePresentationControllerDelegate where Self: UIViewController {
	public func render(oldProps: ModalVC?, props: ModalVC?) {
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
		modalViewController.presentationController?.delegate = self
		modalVC.viewController.update(modalViewController)
		if #available(iOS 13, *) {
			if modalVC.onAttemptToDismiss != nil {
				modalViewController.isModalInPresentation = true
			} else {
				modalViewController.isModalInPresentation = false
			}			
		}
		present(modalViewController, animated: true) {
			modalVC.onPresent?.perform()
		}
	}

	private func dismissModalVC(
		_ oldModalVC: ModalVC,
		completion: (() -> Void)? = nil
	) {
		presentedViewController?.dismiss(animated: true) {
			completion?()
		}
	}

	private func updateModalVC(oldModalVC: ModalVC, modalVC: ModalVC) {
		// Если id изменился прячем старый экран и показываем новый
		// иначе обновляем видимый
		if
			oldModalVC.id != modalVC.id ||
			oldModalVC.modalPresentationStyle != modalVC.modalPresentationStyle
		{
			dismissModalVC(oldModalVC) {
				self.presentModalVC(modalVC)
			}
		} else {
			guard let modalViewController = presentedViewController else {
				return
			}
			
			if #available(iOS 13, *) {
				if modalVC.onAttemptToDismiss != nil {
					modalViewController.isModalInPresentation = true
				} else {
					modalViewController.isModalInPresentation = false
				}
			}
			
			if #available(iOS 13, *) {
				if modalVC.onAttemptToDismiss != nil {
					modalViewController.isModalInPresentation = true
				} else {
					modalViewController.isModalInPresentation = false
				}
			}
			
			modalVC.viewController.update(modalViewController)
		}
	}
}
