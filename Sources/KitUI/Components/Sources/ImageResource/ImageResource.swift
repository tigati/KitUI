import Foundation

public enum ImageResource: Equatable {
	case bundled(Bundled)
	case url(URL)
	
	public struct Bundled: Equatable {
		let name: String
		let bundle: Bundle
		
		public init(name: String, bundle: Bundle) {
			self.name = name
			self.bundle = bundle
		}
	}
}
