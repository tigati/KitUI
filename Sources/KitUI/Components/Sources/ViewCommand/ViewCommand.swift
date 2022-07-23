import Foundation

/// Алиас для `ViewCommandWith` c передаваемым `Void`
public typealias ViewCommand = ViewCommandWith<Void>

/// Алиас для `ReturningViewCommandWith` с возвращаемым `Void`
public typealias ViewCommandWith<TValue> = ReturningViewCommandWith<TValue, Void>

/// Алиас для `ReturningViewCommandWith` с передаваемым `Void`
public typealias ReturningViewCommand<TResult> = ReturningViewCommandWith<Void, TResult>
