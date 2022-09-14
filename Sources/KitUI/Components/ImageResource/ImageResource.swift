import Foundation
import UIKit

public enum ImageResource: Equatable {
	case bundled(Bundled)
	case url(URL)
	case localURL(URL)
	
	public struct Bundled: Equatable {
		public let name: String
		public let bundle: Bundle
		
		public init(name: String, bundle: Bundle) {
			self.name = name
			self.bundle = bundle
		}
	}
}

extension ImageResource.Bundled {
	public var uiImage: UIImage? {
		UIImage(named: name, in: bundle, compatibleWith: nil)
	}
}
