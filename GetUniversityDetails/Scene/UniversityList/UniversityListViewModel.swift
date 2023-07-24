
import Foundation
import RxSwift
import ProgressHUD

class UniversityListViewModel {
    
    var list = PublishSubject<[University]>()
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    var urlString: String {
        return "http://universities.hipolabs.com/search?country="
    }
    
    var screenTitle: String {
        return "University List"
    }
    
    var trimName: String {
        return name.trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
    
    func getUniversityList() {
        guard let url = URL(string: urlString + trimName) else {
            return 
        }
        ProgressHUD.show()
        NetworkManager().fetchRequest(type: [University].self, url: url, completion: {[weak self] result in
            switch result {
            case .success(let newList):
                ProgressHUD.dismiss()
                self?.list.onNext(newList)
                self?.list.onCompleted()
            case .failure(let error):
                ProgressHUD.dismiss()
                print(error)
            }
        })
    }
}
