import Foundation

/// Обёртка над замыканием для вызова из компонента
public final class ReturningViewCommandWith<TValue, TResult> {

	// MARK: - Static
	
	private(set) var id: String?

	/// Пустая реализация для затычек
	public static var empty: ReturningViewCommandWith<TValue, Void> {
		return ReturningViewCommandWith<TValue, Void> { _ in }
	}

	// MARK: - Private properties

	private let action: (TValue) -> TResult

	// MARK: - Lifecycle

	/// Инициализация
	public init(
		action: @escaping (TValue) -> TResult,
		fileID: String = #fileID,
		line: Int = #line,
		column: Int = #column
	) {
		self.action = action
		self.id = fileID + ":\(line)" + ":\(column)"
	}

	// MARK: - Public methods

	/// Выполнение замыкания
	public func perform(with value: TValue) -> TResult {
		action(value)
	}
}

extension ReturningViewCommandWith where TValue == Void {

	/// Выполнение замыкания
	public func perform() -> TResult {
		perform(with: ())
	}
}

extension ReturningViewCommandWith where TValue == Void, TResult == Void {

	/// Выполнение замыкания
	public func perform() {
		perform(with: ())
	}
}

// MARK: - Equatable

extension ReturningViewCommandWith: Equatable {
	public static func == (
		lhs: ReturningViewCommandWith<TValue, TResult>,
		rhs: ReturningViewCommandWith<TValue, TResult>
	) -> Bool {
		guard let lhsID = lhs.id, let rhsID = rhs.id else {
			return false
		}
		return lhsID == rhsID
	}
}

extension ReturningViewCommandWith {
	public func id(_ id: String) -> Self {
		self.id = id
		return self
	}
}
