import Foundation
import UIKit

public struct TextField: IViewProps, Equatable {
	
	public static let type: String = String(reflecting: Self.self)
	
	public static let initial = TextField(
		text: nil,
		placeholder: nil,
		state: .blured(.init(onTap: .empty)),
		traits: .init(),
		style: .initial
	)
	
	public typealias View = TextFieldView
	
	public let text: String?
	public let placeholder: String?
	public let state: State
	public let traits: TextInputTraits
	public let style: Style
	
	public enum State: Equatable {
		case blured(Blured)
		case focused(Focused)
	}

	public struct Focused: Equatable {
		let onUpdate: ViewCommandWith<String?>
		let onFinishEditing: ViewCommand
		let onSubmit: ViewCommand?
		
		public init(
			onUpdate: ViewCommandWith<String?>,
			onFinishEditing: ViewCommand,
			onSubmit: ViewCommand?
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

public struct TextFieldChangeID: Equatable {
	private(set) var id: Int
	
	public mutating func update() {
		if id >= (Int.max - 100) {
			id = 0
		} else {
			id += 1
		}
	}
	
	init() {
		id = -1
	}
	
	public static let initial = TextFieldChangeID()
}
