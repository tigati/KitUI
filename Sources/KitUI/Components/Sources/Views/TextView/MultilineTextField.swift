import Foundation
import UIKit

public struct MultilineTextField: IViewProps, Equatable {

	public typealias View = MultilineTextFieldView
	
	public static let type: String = String(reflecting: Self.self)
	
	public static let initial = MultilineTextField(
		text: nil,
		placeholder: nil,
		keyboardType: .default,
		state: .blured(.init(onTap: .empty)),
		style: .initial
	)
	
	public let text: String?
	public let placeholder: String?
	public let keyboardType: UIKeyboardType
	public let state: State
	public let style: Style
	
	public init(
		text: String?,
		placeholder: String?,
		keyboardType: UIKeyboardType,
		state: MultilineTextField.State,
		style: MultilineTextField.Style
	) {
		self.text = text
		self.placeholder = placeholder
		self.keyboardType = keyboardType
		self.state = state
		self.style = style
	}
	
	public enum State: Equatable {
		case blured(Blured)
		case focused(Focused)
	}

	public struct Focused: Equatable {
		let onUpdate: ViewCommandWith<String?>
		let onFinishEditing: ViewCommand
		
		public init(
			onUpdate: ViewCommandWith<String?>,
			onFinishEditing: ViewCommand
		) {
			self.onUpdate = onUpdate
			self.onFinishEditing = onFinishEditing
		}
	}
	
	public struct Blured: Equatable {
		let onTap: ViewCommand
		
		public init(onTap: ViewCommand) {
			self.onTap = onTap
		}
	}
}

