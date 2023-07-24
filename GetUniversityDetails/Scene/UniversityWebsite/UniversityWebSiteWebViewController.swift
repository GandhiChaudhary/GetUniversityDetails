
import UIKit
import WebKit
import ProgressHUD

class UniversityWebSiteWebViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var webView: WKWebView!
    
    var viewModel: UniversityWebsiteWebViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.screenTitle
        webView.navigationDelegate = self
        loadWebView()
    }
    
    //Loading webView with url
    func loadWebView() {
        guard let urlString = viewModel?.webUrl else { return }
        guard let url = URL(string: urlString) else { return }
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
        ProgressHUD.show()
    }
}

// MARK: - Implementing WKNavigation delegate
extension UniversityWebSiteWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressHUD.dismiss()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ProgressHUD.dismiss()
    }
}



// MARK: - Implementing configurable protocol
extension UniversityWebSiteWebViewController: Configurable {
    func configure(with model: UniversityWebsiteWebViewModel?) {
        viewModel = model
    }
}
