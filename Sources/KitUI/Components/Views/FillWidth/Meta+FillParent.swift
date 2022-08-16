import Foundation

extension MetaView {
	/// Заполняет всё доступное пространство по ширине
	public func fillWidth() -> MetaView {
		.init(props: FillParent(axes: .horizontal, content: self))
	}
	
	public func fillHeight() -> MetaView {
		.init(props: FillParent(axes: .vertical, content: self))
	}
	
	public func fillAll() -> MetaView {
		.init(props: FillParent(axes: .all, content: self))
	}
}
