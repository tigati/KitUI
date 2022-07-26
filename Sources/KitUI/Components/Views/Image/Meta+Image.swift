import Foundation

extension MetaView {
	public static func image(
		id: String? = nil,
		_ resource: ImageResource,
		style: Image.Style = .initial
	) -> MetaView {
		.init(
			props: Image(
				id: id,
				resource: resource,
				style: style
			)
		)
	}
	
	public static func image(
		_ resource: ImageResource.Bundled,
		style: Image.Style = .initial
	) -> MetaView {
		.init(
			props: Image(
				resource: .bundled(resource),
				style: style
			)
		)
	}
}
