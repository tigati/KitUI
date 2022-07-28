import Foundation
import UIKit
import WebKit

public final class WebContentView: ComponentView, IComponent {
	public func render(props: WebContent) {
		guard self.props != props else {
			return
		}
		
		let request = URLRequest(url: props.url)
		webView.load(request)
	}
	
	private var props: WebContent?
	
	public override func setup() {
		addSubview(webView)
	}
	
	private lazy var webView: WKWebView = {
		let config = WKWebViewConfiguration()
		let webView = WKWebView(frame: .zero, configuration: config)
		webView.isOpaque = false
		webView.backgroundColor = UIColor.clear
		webView.scrollView.backgroundColor = UIColor.clear
		webView.navigationDelegate = self
		return webView
	}()
	
	public override func layout() {
		webView.pin.all()
	}
}

extension WebContentView: WKNavigationDelegate {
	public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		props?.onFinishLoading.perform()
	}
	
	public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
		
	}
}
