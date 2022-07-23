import UIKit

/// Протокол компонента
public protocol IComponent {

	/// Пропсы
	associatedtype Props = IProps

	/// Рендерит пропсы
	func render(props: Props)
}
