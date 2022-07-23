import Foundation
import UIKit

/// Описание модального окна
public struct ModalVC: Equatable {

	// MARK: - Public properties

	public var id: String {
		viewController.id
	}

	/// `ViewController`, который отобразиться в модальном окне
	public let viewController: MetaVC

	/// Стиль презентации
	public let modalPresentationStyle: UIModalPresentationStyle

	/// Команда при открытии окна
	public let onPresent: ViewCommand?

	/// Команда при закрытии окна
	public let onDismiss: ViewCommand?

	// MARK: - Lifecycle

	public init(
		viewController: MetaVC,
		modalPresentationStyle: UIModalPresentationStyle,
		onPresent: ViewCommand? = nil,
		onDismiss: ViewCommand? = nil
	) {
		self.viewController = viewController
		self.modalPresentationStyle = modalPresentationStyle
		self.onPresent = onPresent
		self.onDismiss = onDismiss
	}
}
