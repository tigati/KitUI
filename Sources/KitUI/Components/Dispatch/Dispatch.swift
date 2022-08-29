import Foundation

public struct Dispatch<T> {
	
	private let closure: (T) -> Void
	
	public init(closure: @escaping (T) -> Void) {
		self.closure = closure
	}
	
	public func callAsFunction(
		fileID: String = #fileID,
		line: Int = #line,
		column: Int = #column,
		_ argument: T
	) -> ViewCommand {
		return .init(
			action: { closure(argument) },
			fileID: fileID,
			line: line,
			column: column
		)
	}
	
	public func callAsFunction<TValue>(
		fileID: String = #fileID,
		line: Int = #line,
		column: Int = #column,
		_ map: @escaping (TValue) -> T
	) -> ViewCommandWith<TValue> {
		return .init(
			action: { input in closure(map(input)) },
			fileID: fileID,
			line: line,
			column: column
		)
	}
	
	public func perform(_ value: T) {
		closure(value)
	}
}

extension Dispatch {
	public func embed<T2>(_ map: @escaping (T2) -> T) -> Dispatch<T2> {
		Dispatch<T2> { arg in
			let arg2 = map(arg)
			closure(arg2)
		}
	}
}
