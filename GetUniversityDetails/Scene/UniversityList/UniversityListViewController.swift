
import UIKit
import RxSwift
import RxCocoa

class UniversityListViewController: UIViewController {
    
    @IBOutlet weak var universityListTableView: UITableView!
    
    var viewModel: UniversityListViewModel?
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.screenTitle
        BindUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBarBackButton()
    }
    
    func setupNavigationBarBackButton() {
        let backbutton = UIButton(type: .custom)
        backbutton.setTitle("Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal)
        backbutton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func BindUI() {
        viewModel?.list.bind(to: universityListTableView.rx.items (
            cellIdentifier: "cell",
            cellType: UITableViewCell.self)) { row, item, cell in
                cell.textLabel?.text = "University \(row)"
            }.disposed(by: disposeBag)
        universityListTableView.rx.modelSelected(University.self).bind {[weak self] university in
            guard let webUrl = university.webPages?.first else { return }
            self?.navigateToUniversityWebsite(withUrl: webUrl)
        }.disposed(by: disposeBag)
        
        //fetch university list
        viewModel?.getUniversityList()
    }
    
    func navigateToUniversityWebsite(withUrl url: String) {
        guard let webViewController = self.storyboard?.instantiateViewController(withIdentifier: "webView") as? UniversityWebSiteWebViewController else { return }
        let model = UniversityWebsiteWebViewModel(url: url)
        webViewController.configure(with: model)
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
}

// MARK: - Implementing configurable protocol
extension UniversityListViewController: Configurable {
    func configure(with model: UniversityListViewModel?) {
        self.viewModel = model
    }
}
