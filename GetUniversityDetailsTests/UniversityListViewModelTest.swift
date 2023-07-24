
import XCTest
@testable import GetUniversityDetails

private struct TestData {
    static var testViewModel = UniversityListViewModel(name: "Test ")
    static var apiTestModel = UniversityListViewModel(name: "india")
}

class UniversityListViewModelTest: XCTestCase {
    
    var viewModel: UniversityListViewModel?

    override func setUp() {
        super.setUp()
        viewModel = TestData.testViewModel
    }

    override func tearDown() {
        viewModel = nil
    }
    
    // Test viewModel methods
    func testViewModelNameValue() {
        XCTAssertEqual(viewModel?.name, "Test ")
    }
    
    func testScreenTitle() {
        XCTAssertEqual(viewModel?.screenTitle, "University List")
    }
    
    func testTreaming() {
        XCTAssertEqual(viewModel?.trimName, "Test")
    }
    
    func testUniversityLiatApiCall() {
        viewModel = TestData.apiTestModel
        guard let url = URL(string: (viewModel?.urlString ?? "") + (viewModel?.trimName ?? "")) else {
            return
        }
        
        let expectation = expectation(description: " Fetching university list")
        NetworkManager().fetchRequest(type: [University].self, url: url, completion: { result in
            switch result {
            case .success(let newList):
                XCTAssertEqual(newList.count, 862)
                expectation.fulfill()
            case .failure( _):
              break
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
}
