import Foundation

public struct Dispatch<T> {
	
	private let closure: (T) -> Void
	
	public init(closure: @escaping (T) -> Void) {
		self.closure = closure
	}
	
	public func callAsFunction(_ argument: T) -> ViewCommand {
		ViewCommand {
			closure(argument)
		}
	}
	
	public func callAsFunction<TInput>(
		_ map: @escaping (TInput) -> T
	) -> ViewCommandWith<TInput> {
		ViewCommandWith<TInput> { input in
			closure(map(input))
		}
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
