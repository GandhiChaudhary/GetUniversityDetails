
import Foundation
import RxSwift

class UniversityNameInputViewModel {
    
    //RxSwift Subjects
    var universityName = BehaviorSubject(value:"")
    
    var searchTitle: String {
        return "Search Universities"
    }
    
    var isValidName: Bool {
        guard let name = try? universityName.value() else { return false}
        return name.count > 0
    }
    
    var searchButtonTitle: String {
        return "Search"
    }
    
    var listViewModel: UniversityListViewModel? {
        guard let name = try? universityName.value() else { return nil }
        return UniversityListViewModel(name: name)
    }
    
    func getUniversityList(name: String, completion: @escaping(Result<[University], CustomError>) -> Void) {
        guard let url = URL(string: "http://universities.hipolabs.com/search?country=\(name)") else {
            return completion(.failure(.BadURL))
        }
        NetworkManager().fetchRequest(type: [University].self, url: url, completion: completion)
    }
}

