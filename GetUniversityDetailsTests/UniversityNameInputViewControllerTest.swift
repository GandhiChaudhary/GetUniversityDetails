
import XCTest
@testable import GetUniversityDetails

class UniversityNameInputViewControllerTest: XCTestCase {
    
    var viewCotroller: UniversityNameInputViewController?
    var window: UIWindow?

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupViewController()
    }
    
    func setupViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "nameInputVC") as? UniversityNameInputViewController
        controller?.loadViewIfNeeded()
        viewCotroller = controller
        
    }

    override func tearDown() {
        window = nil
        viewCotroller = nil
    }
    
    func testInitalMethods() {
        viewCotroller?.viewDidLoad()
    }
    
    // Test viewModel methods
    func testViewModelUniversityNameValue() {
        viewCotroller?.nameTextField.text = "testing"
        viewCotroller?.BindUI()
        let result = viewCotroller?.viewModel.isValidName
        XCTAssertEqual(result, true)
    }
    
    func testScreenTitle() {
        XCTAssertEqual(viewCotroller?.viewModel.searchTitle, "Search Universities")
    }
    
    func testSearchButtonTitle() {
        XCTAssertEqual(viewCotroller?.viewModel.searchButtonTitle, "Search")
    }
    
    func testListViewModel() {
        XCTAssertNotNil(viewCotroller?.viewModel.listViewModel)
    }

}

