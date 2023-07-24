
import UIKit
import RxSwift
import RxCocoa

class UniversityNameInputViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    //class variables
    var viewModel = UniversityNameInputViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTitle.text = viewModel.searchTitle
        setupSearchButton()
        BindUI()
    }
    
    //set up search button
    func setupSearchButton() {
        searchButton.setTitle(viewModel.searchButtonTitle, for: .normal)
        searchButton.tintColor = .white
        searchButton.backgroundColor = .blue
        searchButton.layer.cornerRadius = 5
    }
    
    //binding UI control with RXSwift
    func BindUI() {
        nameTextField.rx.text.map {$0 ?? ""}.bind(to: viewModel.universityName).disposed(by: disposeBag)
        searchButton.rx.tap.bind {self.searchPressed()}.disposed(by: disposeBag)
    }
    
    // function triggered when user pressed search button
    func searchPressed() {
        switch viewModel.isValidName {
        case true:
            nameTextField.text?.removeAll()
            navigateToUniversityListController()
        case false:
            self.showAlert(with: "University Name Required", message: "Please enter University Name")
        }
    }
    
    func navigateToUniversityListController() {
        let viewModel = viewModel.listViewModel
        guard let listController = self.storyboard?.instantiateViewController(withIdentifier: "UniversityListViewController") as? UniversityListViewController  else { return }
        listController.configure(with: viewModel)
        let NavController = UINavigationController(rootViewController: listController)
        NavController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(NavController, animated: true)
        }
      
    }
}

