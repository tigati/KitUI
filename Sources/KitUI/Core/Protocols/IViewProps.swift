import Foundation
import UIKit

public protocol IViewProps: IProps {

	/// Вью компонента
	associatedtype View = IComponent

	func makeView(viewType: Self.View.Type) -> View

	func updateView(_ view: View)
}

extension IViewProps where View: UIView & IComponent, View.Props == Self {

	public func makeView(viewType: Self.View.Type) -> View {
		viewType.init()
	}

	public func updateView(_ view: View) {
		view.render(props: self)
	}
}

extension IViewProps where View: UIViewController & IComponent, View.Props == Self {

	public func makeView(viewType: Self.View.Type) -> View {
		viewType.init()
	}

	public func updateView(_ view: View) {
		view.render(props: self)
	}
}
