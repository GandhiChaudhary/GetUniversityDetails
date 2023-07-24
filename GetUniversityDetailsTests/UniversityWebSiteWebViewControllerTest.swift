//
//  UniversityWebSiteWebViewControllerTest.swift
//  GetUniversityDetailsTests
//
//  Created by Gandhi Chaudhary on 24/07/23.
//

import XCTest
@testable import GetUniversityDetails

private struct TestData {
    static var testViewModel = UniversityWebsiteWebViewModel(url: "www.google.com")
}

class UniversityWebSiteWebViewControllerTest: XCTestCase {

    var viewCotroller: UniversityWebSiteWebViewController?
    var window: UIWindow?

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupViewController()
    }
    
    func setupViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "webView") as? UniversityWebSiteWebViewController
        controller?.loadViewIfNeeded()
        controller?.configure(with: TestData.testViewModel)
        viewCotroller = controller
        
    }

    override func tearDown() {
        window = nil
        viewCotroller = nil
    }
    
    func testInitalMethods() {
        viewCotroller?.viewDidLoad()
    }
    
    func testWebUrl() {
        XCTAssertEqual(viewCotroller?.viewModel?.webUrl, "www.google.com")
    }
    
    func testScreenTitle() {
        XCTAssertEqual(viewCotroller?.viewModel?.screenTitle, "WebView")
    }

}
