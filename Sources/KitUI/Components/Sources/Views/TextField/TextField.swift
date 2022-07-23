import Foundation
import UIKit

public struct TextField: IViewProps, Equatable {
	
	public static let type: String = String(reflecting: Self.self)
	
	public static let initial = TextField(
		text: nil,
		placeholder: nil,
		isSecureTextEntry: false,
		keyboardType: .default,
		state: .blured(.init(onTap: .empty)),
		style: .initial
	)
	
	public typealias View = TextFieldView
	
	public let text: String?
	public let placeholder: String?
	public let isSecureTextEntry: Bool
	public let keyboardType: UIKeyboardType
	public let state: State
	public let style: Style
	
	public enum State: Equatable {
		case blured(Blured)
		case focused(Focused)
	}

	public struct Focused: Equatable {
		let onUpdate: ViewCommandWith<String?>
		let onFinishEditing: ViewCommand
		let onSubmit: ViewCommand
		
		public init(
			onUpdate: ViewCommandWith<String?>,
			onFinishEditing: ViewCommand,
			onSubmit: ViewCommand
		) {
			self.onUpdate = onUpdate
			self.onFinishEditing = onFinishEditing
			self.onSubmit = onSubmit
		}
	}
	
	public struct Blured: Equatable {
		let onTap: ViewCommand

		public init(onTap: ViewCommand) {
			self.onTap = onTap
		}
	}
}
