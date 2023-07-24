
import Foundation

class UniversityWebsiteWebViewModel {
    
    var webUrl: String
    
    init(url: String) {
        self.webUrl = url
    }
    
    var screenTitle: String {
        return "WebView"
    }
}
