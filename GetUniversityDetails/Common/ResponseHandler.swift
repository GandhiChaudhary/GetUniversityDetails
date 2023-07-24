
import Foundation

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, CustomError>) -> Void)
}

class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, CustomError>) -> Void) {
        let universityList = try? JSONDecoder().decode(type.self, from: data)
        if let list = universityList {
            return completion(.success(list))
        } else {
            completion(.failure(.DecodingError))
        }
    }
}
